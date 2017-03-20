//
//  Recorder.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 20/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import Speech

class Recorder {
  fileprivate let recognizer: SFSpeechRecognizer
  fileprivate let audioEngine: AVAudioEngine

  fileprivate var recognitionTask: SFSpeechRecognitionTask?
  fileprivate var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?

  init() {
    self.audioEngine = AVAudioEngine()
    self.recognizer = SFSpeechRecognizer(locale: Locale.current)!
  }

  func requestAuthorization() {
    if SFSpeechRecognizer.authorizationStatus() != .authorized {
      SFSpeechRecognizer.requestAuthorization {
        status in
      }
    }
  }

  func isRecording() -> Bool {
    return self.audioEngine.isRunning
  }

  func start(recordingCompleted: @escaping (String, Bool) -> Void) {
    if let currentTask = self.recognitionTask {
      currentTask.cancel()
      self.recognitionTask = nil
    }

    let session = AVAudioSession.sharedInstance()
    do {
      try session.setCategory(AVAudioSessionCategoryRecord)
      try session.setMode(AVAudioSessionModeMeasurement)
      try session.setActive(true, with: .notifyOthersOnDeactivation)
    } catch {
      AppDelegate.log.error("Sessio was not setup corectly beause of an error")
    }

    guard let inputNode = self.audioEngine.inputNode else {
      fatalError("Audio enginne has no input node")
    }
    self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    guard let recognitionRequest = self.recognitionRequest else {
      fatalError("Unable to create recognition request")
    }
    recognitionRequest.shouldReportPartialResults = true

    self.recognitionTask = recognizer.recognitionTask(with: recognitionRequest, resultHandler:
      { result, error in
        if let r = result, r.isFinal {
          inputNode.removeTap(onBus: 0)
          recordingCompleted(r.bestTranscription.formattedString, true)
        }
        if let e = error {
          AppDelegate.log.error("Speeech recognition failed \(e)")
          recordingCompleted("", false)
        }
    })

    let format = inputNode.outputFormat(forBus: 0)
    inputNode.installTap(onBus: 0, bufferSize: 1024, format: format, block:
      { buffer, when in
        self.recognitionRequest?.append(buffer)
    })

    self.audioEngine.prepare()

    do {
      try self.audioEngine.start()
    } catch {
      AppDelegate.log.error("Cannot start recording")
    }
  }

  func stop() {
    self.audioEngine.stop()
    self.recognitionRequest?.endAudio()

    self.recognitionRequest = nil
    self.recognitionTask = nil
  }
}

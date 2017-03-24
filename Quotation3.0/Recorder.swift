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

  fileprivate let recordingLock = DispatchQueue(label: "de.hacknext.Alice.record_lock")
  fileprivate var recognitionTask: SFSpeechRecognitionTask?
  fileprivate var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?

  init() {
    self.audioEngine = AVAudioEngine()
    self.recognizer = SFSpeechRecognizer(locale: Locale.current)!

    let session = AVAudioSession.sharedInstance()
    do {
      try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
      // try session.setMode(AVAudioSessionModeMeasurement) // application crashes with this setting
      try session.setActive(true, with: .notifyOthersOnDeactivation)
    } catch {
      AppDelegate.log.error("Sessio was not setup corectly beause of an error")
    }
  }

  func requestAuthorization(callback: @escaping (Bool) -> Void) {
    if AVAudioSession.sharedInstance().recordPermission() == .granted
      && SFSpeechRecognizer.authorizationStatus() == .authorized {
      callback(true)
      return
    }

    self.requestPermission(callback: callback)
  }

  func isRecording() -> Bool {
    return self.audioEngine.isRunning
  }

  func start(recordingCompleted: @escaping (String, Bool) -> Void) {
    self.recordingLock.sync() {
      if let currentTask = self.recognitionTask {
        currentTask.cancel()
        self.recognitionTask = nil
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
          if let r = result {
            recordingCompleted(r.bestTranscription.formattedString, true)
            if r.isFinal {
              if let node = self.audioEngine.inputNode {
                node.removeTap(onBus: 0)
              }
              self.recognitionTask?.cancel()
            }
          }
          if let e = error {
            AppDelegate.log.error("Speeech recognition failed \(e)")
            recordingCompleted("", false)
          }
      })

      let format = inputNode.outputFormat(forBus: 0)
      inputNode.removeTap(onBus: 0)
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
  }

  func stop() {
    self.audioEngine.stop()
    self.audioEngine.reset()
    self.recognitionRequest?.endAudio()

    self.recognitionRequest = nil
    self.recognitionTask = nil
  }

  fileprivate func requestPermission(callback: @escaping (Bool) -> Void) {
    if AVAudioSession.sharedInstance().recordPermission() != .granted {
      AVAudioSession.sharedInstance().requestRecordPermission({
        permission in
        if permission {
          self.requestPermission(callback: callback)
        } else {
          self.requestPermission(callback: callback)
        }
      })
    } else {
      self.requestSpeechRecognition(callback: callback)
    }
  }

  fileprivate func requestSpeechRecognition(callback: @escaping (Bool) -> Void) {
    if SFSpeechRecognizer.authorizationStatus() != .authorized {
      SFSpeechRecognizer.requestAuthorization {
        status in
        if status != .authorized {
          self.requestSpeechRecognition(callback: callback)
        } else {
          callback(true)
        }
      }
    }
  }
}

//
//  PaymentViewModel.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 22/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

class WelcomeViewModel: ViewModel {
  fileprivate let sounds: Sounds
  fileprivate let recorder: Recorder

  init(recorder: Recorder,
       sounds: Sounds) {
    self.sounds = sounds
    self.recorder = recorder
  }

  func requestMicrophoneAccess(callback: @escaping (Bool) -> Void) {
    self.recorder.requestAuthorization(callback: callback)
  }

  func startRecording(callback: @escaping (String, Bool) -> Void) {
    self.sounds.question(afterFinish: {
      self.recorder.start(recordingCompleted: callback)
    })
  }

  func stopRecording() {
    self.recorder.stop()
  }
}

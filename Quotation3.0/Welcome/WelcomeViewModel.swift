//
//  PaymentViewModel.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 22/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

class WelcomeViewModel: ViewModel {
  fileprivate let sounds: Sounds
  fileprivate let speech: Speech
  fileprivate let recorder: Recorder
  fileprivate let userInformation: UserInformation

  init(recorder: Recorder,
       sounds: Sounds,
       speech: Speech,
       userInformation: UserInformation) {
    self.sounds = sounds
    self.speech = speech
    self.recorder = recorder
    self.userInformation = userInformation
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

  func requestContactsAccess(callback: @escaping (Bool) -> Void) {
    self.userInformation.requestForAccess(completionHandler: callback)
  }

  func speak(text: String) {
    self.speech.speek(text)
  }
}

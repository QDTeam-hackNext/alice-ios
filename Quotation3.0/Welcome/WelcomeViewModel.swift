//
//  PaymentViewModel.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 22/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

class WelcomeViewModel: ViewModel {
  fileprivate let recorder: Recorder

  init(recorder: Recorder) {
    self.recorder = recorder
  }

  func requestMicrophoneAccess() {
    self.recorder.requestAuthorization()
  }
}

//
//  GeneralInforationViewModel.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 20/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import Speech

class GeneralInformationViewModel: ViewModel {
  fileprivate let recorder: Recorder

  init(recorder: Recorder) {
    self.recorder = recorder
  }

  func startRecord() {
    self.recorder.start(recordingCompleted: {
      text, success in
      AppDelegate.log.debug("Recording result: \(text)")
    })
    AppDelegate.log.debug("Recording started")
  }

  func stopRecord() {
    if self.recorder.isRecording() {
      self.recorder.stop()
      AppDelegate.log.debug("Recording stopped")
    }
  }
}

//
//  GeneralInforationViewModel.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 20/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import Speech

class GeneralInformationViewModel {

  func isRecording() -> Bool {
    return true
  }

  func startRecord() {
    AppDelegate.log.debug("Recording started")
  }

  func stopRecord() {
    if self.isRecording() {
      AppDelegate.log.debug("Recording stopped")
    }
  }
}

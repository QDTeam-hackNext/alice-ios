//
//  Speech.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 20/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import AVFoundation

class Speech {
  fileprivate let speechSynthesier: AVSpeechSynthesizer

  init() {
    self.speechSynthesier = AVSpeechSynthesizer()
  }

  func speek(_ text: String) {
    let speechUtterance = AVSpeechUtterance(string: text)
    self.speechSynthesier.speak(speechUtterance)
  }
}

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
  fileprivate let delegate = Delegate()

  init() {
    self.speechSynthesier = AVSpeechSynthesizer()
  }

  func speek(_ text: String, afterFinish: @escaping () -> () = {}) {
    let speechUtterance = AVSpeechUtterance(string: text)
    self.delegate.afterFinish = afterFinish
    self.speechSynthesier.delegate = self.delegate
    self.speechSynthesier.speak(speechUtterance)
  }

  fileprivate class Delegate: NSObject, AVSpeechSynthesizerDelegate {
    var afterFinish: (() -> ())?

    fileprivate func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
      self.afterFinish?()
    }
  }
}

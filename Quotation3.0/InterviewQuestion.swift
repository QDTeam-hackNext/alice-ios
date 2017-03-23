//
//  InterviewQuestion.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 23/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

class InterviewQuestion {
  fileprivate let speech: Speech
  fileprivate let sounds: Sounds
  fileprivate let recorder: Recorder

  init(speech: Speech, sounds: Sounds, recorder: Recorder) {
    self.speech = speech
    self.sounds = sounds
    self.recorder = recorder
  }

  func ask(_ question: String, answerCallback: @escaping (String, Bool) -> Void) {
    self.speech.speek(question, afterFinish: {
      self.sounds.question(afterFinish: {
        self.recorder.start(recordingCompleted: answerCallback)
      })
    })
  }
}

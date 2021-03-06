//
//  UserStoryViewModel.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 22/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//


struct AdditionalUserData {
  let occupation: String
  let health: String
  let sport: String
}

class UserStoryViewModel: ViewModel {
  var occupation = ""

  fileprivate let sounds: Sounds
  fileprivate let backend: Backend
  fileprivate let recorder: Recorder

  fileprivate let requiredFields: [PersonalData.Field] = [.occupation]

  fileprivate var conversationId = ""
  fileprivate var personalData: [PersonalData.Field: String] = [:]

  init(sounds: Sounds,
       backend: Backend,
       recorder: Recorder) {
    self.sounds = sounds
    self.backend = backend
    self.recorder = recorder
  }

  func discoverUserData(userInput: @escaping (String, Bool) -> Void,
                        aliceResponse: @escaping (String?, [PersonalData.Field: String]) -> Void) {
    self.sounds.question {
      self.recorder.start {
        text, status in
        userInput(text, status)
        if status {
          let id = self.conversationId.isEmpty ? "start" : self.conversationId
          let data = PersonalData(id: id, input: text, required: self.requiredFields)
          self.backend.personalData(input: data) {
            resp in
            if let r = resp {
              if let id = r.id {
                self.conversationId = id
              }
              if r.fields.count > self.personalData.count {
                self.personalData = r.fields
              }
              aliceResponse(r.message, r.fields)
            }
          }
        }
      }
    }
  }

  func stopRecording() {
    self.recorder.stop()
  }

  func canContinue() -> Bool {
    return self.requiredFields.count == self.personalData.count
  }
}


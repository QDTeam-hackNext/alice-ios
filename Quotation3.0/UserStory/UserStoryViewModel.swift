//
//  UserStoryViewModel.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 22/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

class UserStoryViewModel: ViewModel {
  fileprivate let backend: Backend
  fileprivate let recorder: Recorder

  fileprivate let requiredFields: [PersonalData.Field] = [.occupation]

  fileprivate var conversationId = ""
  fileprivate var personalData: [PersonalData.Field: String] = [:]

  init(backend: Backend,
       recorder: Recorder) {
    self.backend = backend
    self.recorder = recorder
  }

  func discoverUserData(userInput: @escaping (String, Bool) -> Void,
                        aliceResponse: @escaping (String?, [PersonalData.Field: String]) -> Void) {
    self.recorder.start(recordingCompleted: {
      text, status in
      userInput(text, status)
      if status {
        let id = self.conversationId.isEmpty ? "start" : self.conversationId
        let data = PersonalData(id: id, input: text, required: self.requiredFields)
        self.backend.personalData(input: data, callback: {
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
        })
      }
    })
  }

  func stopRecording() {
    self.recorder.stop()
  }

  func canContinue() -> Bool {
    return self.requiredFields.count == self.personalData.count
  }
}

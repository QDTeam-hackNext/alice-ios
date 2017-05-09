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

  fileprivate var conversationId = ""

  init(backend: Backend,
       recorder: Recorder) {
    self.backend = backend
    self.recorder = recorder
  }

  func discoverUserData(userInput: @escaping (String, Bool) -> Void,
                        aliceResponse: @escaping (String?, [PersonalData.Field: String]?) -> Void) {
    self.recorder.start(recordingCompleted: {
      text, status in
      userInput(text, status)
      if status {
        let id = self.conversationId.isEmpty ? "start" : self.conversationId
        let data = PersonalData(id: id, input: text, required: [.occupation, .healthy, .sport])
        self.backend.personalData(input: data, callback: {
          resp in
          if let r = resp {
            if let id = r.id {
              self.conversationId = id
            }
            aliceResponse(resp?.message, resp?.fields)
          }
        })
      }
    })
  }

  func stopRecording() {
    self.recorder.stop()
  }
}

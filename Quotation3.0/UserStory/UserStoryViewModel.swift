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

  func discoverUserData(userDataNotFound: @escaping (String, Bool) -> Void,
                        fundUserData: @escaping (_ msg: String?, _ foundKeys: [String]?) -> Void) {
    self.recorder.start(recordingCompleted: {
      text, status in
      if status {
        let id = self.conversationId.isEmpty ? "start" : self.conversationId
        let data = PersonalData(id: id, input: text, required: ["occupation", "healthy", "sport"])
        self.backend.personalData(input: data, callback: {
          response in
          if let r = response {
            if let id = r.id {
              self.conversationId = id
            }
            if r.collected {
              fundUserData(r.message, r.fields)
              return
            }
          }
          userDataNotFound(text, status)
        })
      } else {
        userDataNotFound(text, status)
      }
    })
  }

  func stopRecording() {
    self.recorder.stop()
  }
}

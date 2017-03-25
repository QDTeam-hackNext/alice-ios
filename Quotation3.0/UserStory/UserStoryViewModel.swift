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

  func discoverUserSata(uiUpdateCallback: @escaping (String, Bool) -> Void,
                        updateAliceCallback: @escaping (_ msg: String?, _ foundKeys: [String]?) -> Void) {
    self.recorder.start(recordingCompleted: {
      text, status in
      uiUpdateCallback(text, status)
//      if status {
//        let id = self.conversationId.isEmpty ? "start" : self.conversationId
//        let data = PersonalData(id: id, input: text, required: ["occupation", "healthy", "sport"])
//        self.backend.personalData(input: data, callback: {
//          response in
//          if let r = response,
//            let id = r.id {
//            self.conversationId = id
//          }
//          AppDelegate.log.info("r: \(response?.collected)")
//          updateAliceCallback(response?.message, response?.fields)
//        })
//      }
    })
  }

  func stopRecording() {
    self.recorder.stop()
  }
}

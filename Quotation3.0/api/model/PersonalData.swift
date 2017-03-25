//
//  PersonalData.swift
//  Alice
//
//  Created by Dariusz Łuksza on 25/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import Argo
import Curry
import Runes

struct PersonalData {
  let id: String
  let input: String
  let required: [String]
  
}

extension PersonalData {
  func toJson() -> [String: AnyObject] {
    return ["id": self.id as AnyObject,
           "input": self.input as AnyObject,
           "required": self.required as AnyObject]
  }
}

struct PersonalResponse {
  let collected: Bool
  let fields: [String]
  let id: String?
  let message: String?
}

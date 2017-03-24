//
//  AnalyzeResult.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 24/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import Argo
import Curry
import Runes

struct AnalyzeResult {
  let fields: MyInfo
}

struct MyInfo {
  let birthDate: String
  let maritalStatus: String
  let occuparion: String
}

extension AnalyzeResult: Decodable {
  static func decode(_ json: JSON) -> Decoded<AnalyzeResult> {
    return curry(AnalyzeResult.init)
      <^> json <| "fileds"
  }
}

extension MyInfo: Decodable {
  static func decode(_ json: JSON) -> Decoded<MyInfo> {
    return curry(MyInfo.init)
     <^> json <| "birth-date"
     <*> json <| "marital-status"
     <*> json <| "occupation"
  }
}

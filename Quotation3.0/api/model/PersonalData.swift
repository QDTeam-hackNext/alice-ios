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
  enum Field: String {
    case occupation = "occupation"
    case healthy = "healthy"
    case sport = "sport"
  }

  let id: String
  let input: String
  let required: [Field]
}

extension PersonalData {
  func toJson() -> [String: AnyObject] {
    return ["id": self.id as AnyObject,
           "input": self.input as AnyObject,
           "required": self.required.map { return $0.rawValue } as AnyObject]
  }
}

extension PersonalData.Field: Decodable {
  static func decode(_ json: JSON) -> Decoded<PersonalData.Field> {
    switch json {
    case let .string(name):
      if let value = PersonalData.Field(rawValue: name) {
        return .success(value)
      }
      return .failure(.custom("Unsupported value: \(name)"))
    default:
      return .failure(.typeMismatch(expected: "string", actual: "\(json)"))
    }
  }
}

struct PersonalResponse {
  let collected: Bool
  let fields: [PersonalData.Field: String]
  let id: String?
  let message: String?
}

extension PersonalResponse: Decodable {
  static func decode(_ json: JSON) -> Decoded<PersonalResponse> {
    return curry(PersonalResponse.init)
      <^> json <| "collected"
      <*> (json <| "fields" >>- decodeFields)
      <*> json <|? "id"
      <*> json <|? "message"
  }
}

func decodeFields(_ json: JSON) -> Decoded<[PersonalData.Field: String]> {
  switch json {
  case let .array(array):
    let result: [PersonalData.Field: String] = array.reduce([:]) {
      accum, element in
      switch element {
      case let .object(obj):
        if let rawKey = obj["name"],
            let rawValue = obj["value"],
            let key = PersonalData.Field.decode(rawKey).value,
            case .string(let value) = rawValue {
          var ret = accum
          ret[key] = value
          return ret
        }
      default:
        return accum
      }
      return accum
    }
    return .success(result)
  default:
    return .failure(.typeMismatch(expected: "array of objects with 'name' and 'value' fields", actual: "\(json)"))
  }
}

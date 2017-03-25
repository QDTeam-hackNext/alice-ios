//
//  Quote.swift
//  Alice
//
//  Created by Dariusz Łuksza on 25/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import Argo
import Curry
import Runes

struct Agreement {
  let period: Int
  let product = "RLV"
  let smokes: Bool
  let startDate: String
  let sum: String
}

extension Agreement {
  func toJson() -> [String: AnyObject] {
    return ["period": self.period as AnyObject,
           "product": self.product as AnyObject,
           "smokes": self.smokes as AnyObject,
           "startDate": self.startDate as AnyObject,
           "sum": self.sum as AnyObject]
  }
}

struct QuoteData {
  let birthDate: String
  let occupation = ""
}

extension QuoteData {
  func toJson() -> [String: AnyObject] {
    return ["birthDate": self.birthDate as AnyObject,
           "occupation": self.occupation as AnyObject]
  }
}

struct Quote {
  let agreement: Agreement
  let data: QuoteData
}

extension Quote {
  func toJson() -> [String: AnyObject] {
    return ["agreement": self.agreement.toJson() as AnyObject,
           "data": self.data.toJson() as AnyObject]
  }
}

struct QuotePremium {
//  let brutto: Double
  let netto: Double
//  let provision: Double
}

extension QuotePremium: Decodable {
  static func decode(_ json: JSON) -> Decoded<QuotePremium> {
    return curry(QuotePremium.init)
//      <^> json <| "brutto"
      <^> json <| "netto"
//      <*> json <| "provision"
  }
}

struct QuoteResult {
  let check: Int
  let premium: QuotePremium
}

extension QuoteResult: Decodable {
  static func decode(_ json: JSON) -> Decoded<QuoteResult> {
    return curry(QuoteResult.init)
      <^> json <| "check"
      <*> json <| "premium"
  }
}

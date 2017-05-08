//
//  Backend.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 24/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import Argo
import Alamofire

fileprivate let headers = ["Content-Type": "application/json;charset=utf-8"]

class Backend {
  fileprivate let urls: BackendUrls

  init (urls: BackendUrls) {
    self.urls = urls
  }

  func analyze(callback: @escaping (AnalyzeResult?) -> Void) {
    Alamofire.request(urls.analysis)
      .responseJSON(completionHandler: {
        resp in
        if let data = resp.data,
            resp.response?.statusCode == 200 {
          let decoded: AnalyzeResult? = decode(data)
          callback(decoded)
        }
      })
  }

  func quickQuote(_ quote: Quote, callback: @escaping (String?) -> Void) {
    Alamofire.request(self.urls.quickQuote,
                      method: .post,
                      parameters: quote.toJson(),
                      encoding: JSONEncoding.default,
                      headers: headers)
      .responseJSON(completionHandler: {
        resp in
        if let data = resp.result.value as? NSDictionary,
            resp.response?.statusCode == 200 {
          let netto = (data["premium"] as! NSDictionary)["netto"] as? Double
          callback("\(netto!)")
        }
      })
  }

  func personalData(input: PersonalData, callback: @escaping (PersonalResponse?) -> Void) {
    Alamofire.request(self.urls.personalData,
                      method: .post,
                      parameters: input.toJson(),
                      encoding: JSONEncoding.default,
                      headers: headers)
      .responseJSON(completionHandler: {
        resp in
        if let data = resp.result.value as? NSDictionary,
            resp.response?.statusCode == 200 {
          let collected = data["collected"] as! Bool
          let fields = data["fields"] as! [String]
          let id = data["id"] as? String
          let message = data["message"] as? String

          let personal = PersonalResponse(collected: collected, fields: fields, id: id, message: message)
          callback(personal)
        }
      })
  }
}

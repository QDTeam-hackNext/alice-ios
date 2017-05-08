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
        if let json = resp.result.value {
          let decoded: AnalyzeResult? = decode(json)
          callback(decoded)
        }
      })
  }

  func quickQuote(_ quote: Quote, callback: @escaping (QuoteResult?) -> Void) {
    Alamofire.request(self.urls.quickQuote,
                      method: .post,
                      parameters: quote.toJson(),
                      encoding: JSONEncoding.default,
                      headers: headers)
      .responseJSON(completionHandler: {
        resp in
        if let json = resp.result.value {
          let decoded: QuoteResult? = decode(json)
          callback(decoded)
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
        if let json = resp.result.value {
          let decoded: PersonalResponse? = decode(json)
          callback(decoded)
        }
      })
  }
}

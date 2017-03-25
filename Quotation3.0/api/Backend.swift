//
//  Backend.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 24/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import Argo
import Alamofire

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

  func quickQuote(_ quote: Quote, callback: @escaping (QuoteResult?) -> Void) {
    Alamofire.request(self.urls.quickQuote,
                      method: HTTPMethod.post,
                      parameters: quote.toJson(),
                      encoding: JSONEncoding.default)
      .responseJSON(completionHandler: {
        resp in
        if let data = resp.result.value,
            resp.response?.statusCode == 200 {
          let decoded: QuoteResult? = decode(data as AnyObject)
          callback(decoded)
        }
      })
  }
}

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
}

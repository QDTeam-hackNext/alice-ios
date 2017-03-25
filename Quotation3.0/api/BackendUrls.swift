//
//  BackendUrls.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 24/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

class BackendUrls {
  let analysis: String
  let quickQuote: String

  init(appConfig: AppConfig) {
    self.analysis = appConfig.backendUrl + "api/analysis"
    self.quickQuote = appConfig.backendUrl + "api/policies/quick_quote"
  }
}

//
//  GeneralInforationViewModel.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 20/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import Contacts

class GeneralInformationViewModel: ViewModel {
  fileprivate let backend: Backend
  fileprivate let userInfo: UserInformation

  var userData: CNContact?

  init(backend: Backend,
       userInfo: UserInformation) {
    self.backend = backend
    self.userInfo = userInfo
  }

  func userRealName() -> String {
    if self.userData == nil {
      self.fetchUserData()
    }
    return self.userData?.givenName ?? ""
  }

  func calculateQuote(period: Int, smokes: Bool, sum: String, callback: @escaping (String) -> Void) {
    let agreement = Agreement(period: period, smokes: smokes, startDate: "2017-04-30", sum: sum)
    let quoteData = QuoteData(birthDate: "\(self.userData?.birthday?.year ?? 1986)-\(self.userData?.birthday?.month ?? 5)-\(self.userData?.birthday?.day ?? 5)")
    let quote = Quote(agreement: agreement, data: quoteData)
    self.backend.quickQuote(quote) {
      result in
      if let r = result {
        callback("\(r)")
      }
    }
  }

  fileprivate func fetchUserData() {
    self.userInfo.loadUserContact(callback: {
      userData in
      self.userData = userData
    })
  }
}

//
//  GeneralInforationViewModel.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 20/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import Contacts

class GeneralInformationViewModel: ViewModel {
  fileprivate let userInfo: UserInformation

  fileprivate var userData: CNContact?

  init(userInfo: UserInformation) {
    self.userInfo = userInfo
  }

  func userRealName() -> String {
    if self.userData == nil {
      self.fetchUserData()
    }
    return self.userData?.givenName ?? ""
  }

  fileprivate func fetchUserData() {
    self.userInfo.loadUserContact(callback: {
      userData in
      self.userData = userData
    })
  }
}

//
//  AdditionalQuestionsViewModel.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 22/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

class AdditionalQuestionsViewModel: ViewModel {
  var data: GeneralInformationData?
  var additionalData: AdditionalUserData?

  fileprivate let health: HealthKit

  init(health: HealthKit) {
    self.health = health
  }

  func requestHealthAccess(callback: @escaping (Bool) -> Void) {
    self.health.authorize(callback: callback)
  }
}

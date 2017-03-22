//
//  SwinjectStoryboard.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 22/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
  class func setup() {
    self.registerViewModels()

    self.defaultContainer
      .register(Speech.self, factory: { _ in return Speech() })
    self.defaultContainer
      .register(Recorder.self, factory: { _ in return Recorder() })
    self.defaultContainer
      .register(Sounds.self, factory: { _ in return Sounds() })
  }

  fileprivate class func registerViewModels() {
    self.defaultContainer
      .register(WelcomeViewModel.self, factory: { _ in return WelcomeViewModel() })
    self.defaultContainer
      .register(GeneralInformationViewModel.self, factory: {
        r in
        return GeneralInformationViewModel(recorder: resolve(r))
      })
    self.defaultContainer
      .register(UserStoryViewModel.self, factory: { _ in return UserStoryViewModel() })
    self.defaultContainer
      .register(AdditionalQuestionsViewModel.self, factory: { _ in return AdditionalQuestionsViewModel() })
    self.defaultContainer
      .register(DataAccessViewModel.self, factory: { _ in return DataAccessViewModel() })
    self.defaultContainer
      .register(SummaryViewModel.self, factory: { _ in return SummaryViewModel() })
    self.defaultContainer
      .register(PaymentViewModel.self, factory: { _ in return PaymentViewModel() })
  }

  fileprivate class func resolve<Serivce>(_ r: Resolver) -> Serivce {
    return r.resolve(Serivce.self)!
  }
}

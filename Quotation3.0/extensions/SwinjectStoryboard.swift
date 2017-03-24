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
      .inObjectScope(.container)
    self.defaultContainer
      .register(Recorder.self, factory: { _ in return Recorder() })
      .inObjectScope(.container)
    self.defaultContainer
      .register(Sounds.self, factory: { _ in return Sounds() })
      .inObjectScope(.container)
    self.defaultContainer
      .register(InterviewQuestion.self, factory: {
        r in
        return InterviewQuestion(speech: resolve(r),
                                 sounds: resolve(r),
                                 recorder: resolve(r))
      })
      .inObjectScope(.container)
    self.defaultContainer
      .register(BackendUrls.self, factory: { _ in return BackendUrls() })
      .inObjectScope(.container)
    self.defaultContainer
      .register(Backend.self, factory: {
        r in
        return Backend(urls: resolve(r)) })
      .inObjectScope(.container)
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

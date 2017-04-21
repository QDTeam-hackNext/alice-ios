//
//  AppDelegate.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 20/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import UIKit
import XCGLogger
import Swinject
import SwinjectAutoregistration

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  static let log = XCGLogger.default
  static let container: Container = {
    let c = Container()
    c.autoregister(AppConfig.self, initializer: AppConfig.init)
    c.autoregister(Speech.self, initializer: Speech.init)
    c.autoregister(Recorder.self, initializer: Recorder.init)
    c.autoregister(Sounds.self, initializer: Sounds.init)
    c.autoregister(ExternalApps.self, initializer: ExternalApps.init)
    c.autoregister(InterviewQuestion.self, initializer: InterviewQuestion.init)
    c.autoregister(ExternalApps.self, initializer: ExternalApps.init)
    c.autoregister(BackendUrls.self, initializer: BackendUrls.init)
    c.autoregister(Backend.self, initializer: Backend.init)
    c.autoregister(UserInformation.self, initializer: UserInformation.init)
    c.autoregister(HealthKit.self, initializer: HealthKit.init)
    c.autoregister(WelcomeViewModel.self, initializer: WelcomeViewModel.init)
    c.autoregister(GeneralInformationViewModel.self, initializer: GeneralInformationViewModel.init)
    c.autoregister(UserStoryViewModel.self, initializer: UserStoryViewModel.init)
    c.autoregister(AdditionalQuestionsViewModel.self, initializer: AdditionalQuestionsViewModel.init)
    c.autoregister(DataAccessViewModel.self, initializer: DataAccessViewModel.init)
    c.autoregister(SummaryViewModel.self, initializer: SummaryViewModel.init)
    c.autoregister(PaymentViewModel.self, initializer: PaymentViewModel.init)
    return c
  }()

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    // initialize speech api
    AppDelegate.container.resolve(Speech.self)!.speek(" ")
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}


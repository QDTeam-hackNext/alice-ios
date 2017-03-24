//
//  ExternalApps.swift
//  Alice
//
//  Created by Dariusz Łuksza on 24/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import UIKit
import Foundation

class ExternalApps {

  func hasStrava() -> Bool {
    return open("strava://")
  }

  func hasGarmin() -> Bool {
    return open("gcm-ciq://")
  }

  fileprivate func open(_ scheme: String) -> Bool {
    if let url = URL(string: scheme) {
      return UIApplication.shared.canOpenURL(url)
    }
    return false
  }
}

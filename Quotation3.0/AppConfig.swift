//
//  AppConfig.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 24/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import Foundation

class AppConfig {
  let backendUrl: String

  init () {
    let path = Bundle.main.path(forResource: "appConfig", ofType: "plist")!
    let url = URL(fileURLWithPath: path)
    let data = try! Data(contentsOf: url)
    let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
    let dictArray = plist as! [String:String]

    self.backendUrl =  dictArray["backendUrl"]!
  }
}

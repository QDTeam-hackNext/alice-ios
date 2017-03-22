//
//  ViewModel.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 22/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import Foundation
import SwinjectStoryboard

protocol ModelData {}

protocol ViewModel {}

class ViewModelWithData<Data: ModelData>: ViewModel {
  var data: Data?
}

protocol WithViewModel {
  associatedtype Model: ViewModel

  var model: Model { get }
}

private var modelKey: UInt8 = 0

extension WithViewModel {
  var model: Model {
    get {
      guard let m = objc_getAssociatedObject(self, &modelKey) as? Model else {
        let new = SwinjectStoryboard.defaultContainer.resolve(Model.self)!
        objc_setAssociatedObject(self, &modelKey, new, .OBJC_ASSOCIATION_RETAIN)
        return new
      }
      return m
    }
  }
}

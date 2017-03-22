//
//  ViewModel.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 22/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import UIKit
import SwinjectStoryboard

protocol ModelData {

}

protocol ViewModel {

}

class ViewModelWithData<Data: ModelData>: ViewModel {
  var data: Data?
}

class UIViewControllerWithViewModel<Model: ViewModel>: UIViewController {
  let model: Model

  required init?(coder: NSCoder) {
    self.model =  SwinjectStoryboard.defaultContainer.resolve(Model.self)!

    super.init(coder: coder)
  }
}

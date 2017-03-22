//
//  ViewModel.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 22/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import UIKit

protocol ModelData {

}

protocol ViewModel {

}

class ViewModelWithData<Data: ModelData>: ViewModel {
  var data: Data?
}

class UIViewControllerWithViewModel<Model: ViewModel>: UIViewController {
  var model: Model?
}

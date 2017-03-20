//
//  GeneralInformationView.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 20/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import UIKit

class GeneralIfomationView: UIViewController {
  @IBOutlet weak var recordButton: UIButton!
  
  fileprivate var model = GeneralInformationViewModel()

  override func viewDidLoad() {
    Speech().speek("I hope that it will sound like Siri and won't be necessary to use Siri explicitly")
  }

  @IBAction func recordButtonTouchDown(_ sender: Any) {
    self.model.startRecord()
  }

  @IBAction func recordButtonTouchUpInside(_ sender: Any) {
    self.model.stopRecord()
  }

  @IBAction func recordButtonTouchUpOutside(_ sender: Any) {
    self.model.stopRecord()
  }
}

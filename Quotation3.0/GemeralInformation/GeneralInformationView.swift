//
//  GeneralInformationView.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 20/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import UIKit
import SwinjectStoryboard

class GeneralIfomationView: UIViewController, WithViewModel {
  typealias Model = GeneralInformationViewModel

  @IBOutlet weak var recordButton: UIButton!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var answerLabel: UILabel!

  override func viewDidLoad() {

  }

  @IBAction func recordButtonTouchDown(_ sender: Any) {
    SwinjectStoryboard.defaultContainer.resolve(InterviewQuestion.self)!.ask(self.questionLabel.text!, answerCallback: {
      answer, _ in
      AppDelegate.log.info("answer: \(answer)")
      self.answerLabel.text = answer
    })
  }

  @IBAction func recordButtonTouchUpInside(_ sender: Any) {
    self.model.stopRecord()
  }

  @IBAction func recordButtonTouchUpOutside(_ sender: Any) {
    self.model.stopRecord()
  }
}

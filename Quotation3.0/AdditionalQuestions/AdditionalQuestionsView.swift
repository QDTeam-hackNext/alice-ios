//
//  AdditionalQuestionsView.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 22/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import UIKit

class AdditionalQuestionsView: UIViewController, WithViewModel {
  typealias Model = AdditionalQuestionsViewModel

  @IBOutlet weak var container: UIView!
  @IBOutlet weak var aliceTextLabel: UILabel!
  @IBOutlet var appNames: [UILabel]!
  @IBOutlet var diviers: [UILabel]!
  @IBOutlet weak var healthDiscountLabel: UILabel!
  @IBOutlet weak var nikeDiscountLabel: UILabel!
  @IBOutlet weak var stravaDiscount: UILabel!
  @IBOutlet weak var foursquareDiscountLabel: UILabel!

  @IBOutlet weak var healthSwitch: UISwitch!
  @IBOutlet weak var nikeSwitch: UISwitch!
  @IBOutlet weak var stravaSwitch: UISwitch!
  @IBOutlet weak var foursquareSwitch: UISwitch!

  @IBOutlet weak var summaryButton: UIButton!

  override func viewDidLoad() {
    self.view.backgroundColor = UIColor.background

    self.aliceTextLabel.numberOfLines = 0
    self.aliceTextLabel.lineBreakMode = .byWordWrapping
    self.aliceTextLabel.textColor = UIColor.charcoalGrey
    self.aliceTextLabel.font = UIFont.aliceMessageFontFont()

    for label in self.appNames {
      label.font = UIFont.sumaryNameFontFont()
      label.textColor = UIColor.slate
    }
    for label in self.diviers {
      label.text = ""
      label.backgroundColor = UIColor.slate10
    }

    self.healthSwitch.setOn(false, animated: false)
    self.nikeSwitch.setOn(false, animated: false)
    self.stravaSwitch.setOn(false, animated: false)
    self.foursquareSwitch.setOn(false, animated: false)

    self.styleDiscount(label: self.healthDiscountLabel)
    self.styleDiscount(label: self.nikeDiscountLabel)
    self.styleDiscount(label: self.stravaDiscount)
    self.styleDiscount(label: self.foursquareDiscountLabel)

    self.summaryButton.backgroundColor = UIColor.vividPurple
    self.summaryButton.layer.cornerRadius = 8
    self.summaryButton.clipsToBounds = true
    self.summaryButton.titleLabel?.font = UIFont.buttonFontFont()
    self.summaryButton.setTitleColor(UIColor.white, for: .normal)
  }

  fileprivate func styleDiscount(label: UILabel) {
    label.isHidden = true
    label.textColor = UIColor.green
    label.font = UIFont.appDiscountFontFont()
  }
}

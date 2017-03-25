//
//  UserStoryView.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 22/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import UIKit

class UserStoryView: UIViewController, WithViewModel {
  typealias Model = UserStoryViewModel

  @IBOutlet weak var container: UIView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ageLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet var labels: [UILabel]!
  @IBOutlet weak var sposeLabelValue: UILabel!
  @IBOutlet weak var phoneLabelValue: UILabel!
  @IBOutlet weak var emailLabelValue: UILabel!
  @IBOutlet weak var coverageLabelValue: UILabel!
  @IBOutlet weak var yearsOfProtectionLabelValue: UILabel!
  @IBOutlet weak var dividerLabel: UILabel!
  @IBOutlet weak var monthlyFeeValueLabel: UILabel!
  @IBOutlet weak var aliceTextLabel: UILabel!
  @IBOutlet weak var applyButton: UIButton!

  override func viewDidLoad() {
    self.view.backgroundColor = UIColor.background

    self.container.layer.cornerRadius = 8
    self.container.clipsToBounds = true

    self.ageLabel.textColor = UIColor.dodgerBlueTwo
    self.ageLabel.font = UIFont.sumaryAgeFontFont()
    self.addressLabel.textColor = UIColor.slate50
    self.addressLabel.font = UIFont.questionFontFont()
    self.styleKeyLabel(label: nameLabel)
    for label in labels {
      self.styleKeyLabel(label: label)
    }
    self.styleKeyLabel(label: aliceTextLabel)
    self.styleValueLabel(label: sposeLabelValue)
    self.styleValueLabel(label: phoneLabelValue)
    self.styleValueLabel(label: emailLabelValue)
    self.styleValueLabel(label: coverageLabelValue)
    self.styleValueLabel(label: yearsOfProtectionLabelValue)

    self.dividerLabel.text = ""
    self.dividerLabel.backgroundColor = UIColor.slate10

    self.monthlyFeeValueLabel.textColor = UIColor.green
    self.monthlyFeeValueLabel.font = UIFont.partialPriceFontFont()

    self.applyButton.backgroundColor = UIColor.vividPurple
    self.applyButton.layer.cornerRadius = 8
    self.applyButton.clipsToBounds = true
    self.applyButton.titleLabel?.font = UIFont.buttonFontFont()
    self.applyButton.setTitleColor(UIColor.white, for: .normal)
  }

  fileprivate func styleKeyLabel(label: UILabel) {
    label.font = UIFont.questionHeaderFontFont()
  }

  fileprivate func styleValueLabel(label: UILabel) {
    label.textColor = UIColor.dodgerBlueTwo
    label.font = UIFont.summaryValueFontFont()
  }
}

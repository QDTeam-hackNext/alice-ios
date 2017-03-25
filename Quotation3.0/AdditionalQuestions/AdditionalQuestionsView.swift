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
  @IBOutlet weak var aliceImage: UIImageView!
  @IBOutlet weak var aliceTextImage: UIImageView!
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

  @IBOutlet weak var healthOverlay: UIView!
  @IBOutlet weak var healthMsg: UILabel!
  @IBOutlet weak var healthLabel: UILabel!
  @IBOutlet weak var bottomLabel: UILabel!
  fileprivate var generalData: GeneralInformationData?

  func setData(generalData: GeneralInformationData) {
    self.generalData = generalData
  }

  override func viewDidLoad() {
    self.healthOverlay.isHidden = true
    self.view.backgroundColor = UIColor.background

    self.container.layer.cornerRadius = 8
    self.container.clipsToBounds = true

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

    self.healthOverlay.layer.cornerRadius = 8
    self.healthOverlay.clipsToBounds = true

    self.healthMsg.textAlignment = .center
    self.healthMsg.font = UIFont.headerFontFont()
    self.healthMsg.textColor = UIColor.charcoalGrey

    self.healthLabel.font = UIFont.sumaryNameFontFont()
    self.healthLabel.textColor = UIColor.slate

    self.bottomLabel.text = ""
    self.bottomLabel.backgroundColor = UIColor.vividPurple
    self.aliceSayPrice(price: (self.generalData?.price)!)
  }

  fileprivate func styleDiscount(label: UILabel) {
    label.isHidden = true
    label.textColor = UIColor.green
    label.font = UIFont.appDiscountFontFont()
  }

  @IBAction func healthChwithValueChanged(_ sender: Any) {
    if self.healthSwitch.isOn {
      self.aliceImage.isHidden = true
      self.aliceTextLabel.isHidden = true
      self.aliceTextImage.isHidden = true
      self.summaryButton.isHidden = true
      self.healthOverlay.isHidden = false
      self.model.requestHealthAccess(callback: {
        _ in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
          self.aliceImage.isHidden = false
          self.aliceTextLabel.isHidden = false
          self.aliceTextImage.isHidden = false
          self.summaryButton.isHidden = false
          self.healthOverlay.isHidden = true
          self.healthDiscountLabel.text = "Great shape -10%"
          self.healthDiscountLabel.isHidden = false
          self.aliceSayPrice(price: "\(Double((self.generalData?.price)!)! * 0.9)")
        })
      })
    } else {self.aliceSayPrice(price: (self.generalData?.price)!)
      self.healthDiscountLabel.isHidden = true
    }
  }

  fileprivate func aliceSayPrice(price: String) {
    DispatchQueue.main.async {
      if !price.isEmpty {
        self.aliceTextLabel.text = "\(self.generalData!.user.givenName), your current quote is \(price)€"
      } else {
        self.aliceTextLabel.text = "I'm checking price for you"
      }
      //      let formattedText = NSAttributedString(string: text)
      //      self.aliceTextLabel.attributedText = formattedText
    }
  }
}

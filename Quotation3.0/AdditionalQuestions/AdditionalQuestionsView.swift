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
  @IBOutlet weak var aliceSays: AliceSaysView!
  @IBOutlet var diviers: [UILabel]!

  @IBOutlet weak var healthExternalApp: ExternalAppView!
  @IBOutlet weak var nikeExternalApp: ExternalAppView!
  @IBOutlet weak var stravaExternalApp: ExternalAppView!
  @IBOutlet weak var foursquareExternalApp: ExternalAppView!
  
  @IBOutlet weak var summaryButton: UIButton!

  @IBOutlet weak var healthOverlay: UIView!
  @IBOutlet weak var healthMsg: UILabel!
  @IBOutlet weak var healthLabel: UILabel!
  @IBOutlet weak var bottomLabel: UILabel!

  override func viewDidLoad() {
    self.healthOverlay.isHidden = true
    self.view.backgroundColor = UIColor.background

    self.container.layer.cornerRadius = 8
    self.container.clipsToBounds = true

    for label in self.diviers {
      label.text = ""
      label.backgroundColor = UIColor.slate10
    }
    self.healthExternalApp.icon.image = UIImage(named: "iconHealth")
    self.healthExternalApp.nameLabel.text = "Health"
    self.nikeExternalApp.icon.image = UIImage(named: "iconNike")
    self.nikeExternalApp.nameLabel.text = "Nike+ Run Club"
    self.stravaExternalApp.icon.image = UIImage(named: "iconStrava")
    self.stravaExternalApp.nameLabel.text = "Strava"
    self.foursquareExternalApp.icon.image = UIImage(named: "iconFoursquare")
    self.foursquareExternalApp.nameLabel.text = "Foursquare"

    self.healthExternalApp.toggleSwitch.addTarget(self,
                                                  action: #selector(healthSwitchValueChanged),
                                                  for: .valueChanged)

    self.summaryButton.backgroundColor = UIColor.vividPurple
    self.summaryButton.layer.cornerRadius = 8
    self.summaryButton.clipsToBounds = true
    self.summaryButton.titleLabel?.font = UIFont.buttonFontFont()
    self.summaryButton.setTitleColor(UIColor.white, for: .normal)

    self.healthOverlay.layer.cornerRadius = 8
    self.healthOverlay.clipsToBounds = true

    self.healthMsg.numberOfLines = 0
    self.healthMsg.lineBreakMode = .byWordWrapping
    self.healthMsg.textAlignment = .center
    self.healthMsg.font = UIFont.headerFontFont()
    self.healthMsg.textColor = UIColor.charcoalGrey
    self.healthMsg.text = "\(self.model.data?.user.givenName ?? ""), please give me few seconds. I need to get few things from:"

    self.healthLabel.font = UIFont.sumaryNameFontFont()
    self.healthLabel.textColor = UIColor.slate

    self.bottomLabel.text = ""
    self.bottomLabel.backgroundColor = UIColor.vividPurple
    self.aliceSayPrice(price: (self.model.data?.price)!)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toDataAccess" {
      let controller = segue.destination as! DataAccessView
      controller.model.data = self.model.data
    }
  }

  @IBAction func summaryTouch(_ sender: Any) {
    self.performSegue(withIdentifier: "toDataAccess", sender: self)
  }

  func healthSwitchValueChanged(_ sender: Any) {
    if self.healthExternalApp.toggleSwitch.isOn {
      self.aliceSays.isHidden = true
      self.container.isHidden = true
      self.summaryButton.isHidden = true
      self.healthOverlay.isHidden = false
      self.model.requestHealthAccess(callback: {
        _ in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
          self.aliceSays.isHidden = false
          self.container.isHidden = false
          self.summaryButton.isHidden = false
          self.healthOverlay.isHidden = true
          self.healthExternalApp.discountLabel.text = "Great shape -10%"
          self.healthExternalApp.discountLabel.isHidden = false
          self.aliceSayPrice(price: "\(Double((self.model.data?.price)!)! * 0.9)")
        })
      })
    } else {self.aliceSayPrice(price: (self.model.data?.price)!)
      self.healthExternalApp.discountLabel.isHidden = true
    }
  }

  fileprivate func aliceSayPrice(price: String) {
    DispatchQueue.main.async {
      if !price.isEmpty {
        self.aliceSays.text.text = "\(self.model.data?.user.givenName ?? ""), your current quote is \(price)€"
      } else {
        self.aliceSays.text.text = "I'm checking price for you"
      }
      //      let formattedText = NSAttributedString(string: text)
      //      self.aliceTextLabel.attributedText = formattedText
    }
  }
}

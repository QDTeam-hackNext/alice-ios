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

  @IBOutlet weak var container2: UIView!
  @IBOutlet weak var alice1Label: UILabel!
  @IBOutlet weak var user1Label: UILabel!
  @IBOutlet weak var alice2Label: UILabel!
  @IBOutlet weak var user3Label: UILabel!
  @IBOutlet weak var alice3Label: UILabel!
  @IBOutlet weak var waveView: WaveformView!
  @IBOutlet weak var recordingBacground: UILabel!
  @IBOutlet weak var recordButton: UIButton!

  override func viewDidLoad() {
    self.container2.isHidden = true
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

    self.container2.backgroundColor = UIColor.clear

    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.prominent)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.alpha = 0.9
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    blurEffectView.frame = CGRect(x: 0, y: 0,
                                  width: self.container2.frame.width,
                                  height: self.container2.frame.height - self.recordingBacground.frame.height)
    self.container2.addSubview(blurEffectView)
    self.container2.addSubview(self.alice1Label)
    self.container2.addSubview(self.alice2Label)
    self.container2.addSubview(self.alice3Label)
    self.container2.addSubview(self.user1Label)
    self.container2.addSubview(self.user3Label)
    self.container2.addSubview(self.waveView)
    self.container2.addSubview(self.dividerLabel)

    self.styleAliceLable(label: self.alice1Label)
    self.styleAliceLable(label: self.alice2Label)
    self.styleAliceLable(label: self.alice3Label)
    self.alice1Label.isHidden = false

    self.styleUserLabel(label: self.user1Label)
    self.styleUserLabel(label: self.user3Label)

    self.waveView.isHidden = true
    self.waveView.numberOfWaves = 4
    self.waveView.waveColor = UIColor.dodgerBlue
    self.waveView.backgroundColor = UIColor.clear

    self.dividerLabel.text = ""
    self.dividerLabel.backgroundColor = UIColor.dodgerBlue

    self.recordingBacground.text = ""
    self.recordingBacground.backgroundColor = UIColor.vividPurple

    self.recordButton.setTitle("", for: .normal)
    self.recordButton.layer.cornerRadius = 0.5 * self.recordButton.bounds.size.width
    self.recordButton.clipsToBounds = true
    self.recordButton.layer.borderWidth = 2
    self.recordButton.layer.borderColor = UIColor.white.cgColor
  }

  @IBAction func applyButtonPushed(_ sender: Any) {
    self.container2.isHidden = false
  }

  @IBAction func recordingButtonDown(_ sender: Any) {
  }

  @IBAction func recordingButtonTouchUp(_ sender: Any) {
  }

  fileprivate func styleKeyLabel(label: UILabel) {
    label.font = UIFont.questionHeaderFontFont()
  }

  fileprivate func styleValueLabel(label: UILabel) {
    label.textColor = UIColor.dodgerBlueTwo
    label.font = UIFont.summaryValueFontFont()
  }

  fileprivate func styleAliceLable(label: UILabel) {
    label.isHidden = true
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .left
    label.textColor = UIColor.darkishBlue
    label.font = UIFont.recordHelpMessageFont()
  }

  fileprivate func styleUserLabel(label: UILabel) {
    label.text = ""
    label.isHidden = true
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .right
    label.textColor = UIColor.charcoalGrey
    label.font = UIFont.userSpeechResponseFontFont()
  }
}

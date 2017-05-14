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
  @IBOutlet weak var aliceSays: AliceSaysView!
  @IBOutlet weak var applyButton: UIButton!

  @IBOutlet weak var container2: UIView!
  @IBOutlet weak var scroolContainer: UIScrollView!
  @IBOutlet var aliceLabels: [UILabel]!
  @IBOutlet var userLabels: [UILabel]!
  @IBOutlet weak var waveView: WaveformView!
  @IBOutlet weak var recordingBacground: UILabel!
  @IBOutlet weak var recordButton: UIButton!

  fileprivate var readyForNextStep = false
  fileprivate var displayLink: CADisplayLink?
  fileprivate var generalData: GeneralInformationData?

  func setData(generalData: GeneralInformationData) {
    self.generalData = generalData
  }

  override func viewDidLoad() {
    self.container2.isHidden = true
    self.view.backgroundColor = UIColor.background

    self.container.layer.cornerRadius = 8
    self.container.clipsToBounds = true

    self.ageLabel.textColor = UIColor.dodgerBlueTwo
    self.ageLabel.font = UIFont.sumaryAgeFontFont()
    self.addressLabel.numberOfLines = 0
    self.addressLabel.lineBreakMode = .byWordWrapping
    self.addressLabel.textColor = UIColor.slate50
    self.addressLabel.font = UIFont.questionFontFont()
    self.styleKeyLabel(label: nameLabel)
    for label in labels {
      self.styleKeyLabel(label: label)
    }
    self.styleKeyLabel(label: self.aliceSays.text)
    self.styleValueLabel(label: self.sposeLabelValue)
    self.styleValueLabel(label: self.phoneLabelValue)
    self.styleValueLabel(label: self.emailLabelValue)
    self.styleValueLabel(label: self.coverageLabelValue)
    self.styleValueLabel(label: self.yearsOfProtectionLabelValue)

    self.dividerLabel.text = ""
    self.dividerLabel.backgroundColor = UIColor.slate10

    self.monthlyFeeValueLabel.textColor = UIColor.green
    self.monthlyFeeValueLabel.font = UIFont.partialPriceFontFont()
    let dayQuestion = "\(self.generalData?.user.givenName ?? ""), tell me about your typical day"
    self.aliceSays.text.text = dayQuestion
    self.aliceLabels.first!.text = dayQuestion

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
    self.container2.addSubview(self.scroolContainer)
    self.container2.addSubview(self.waveView)
    self.container2.addSubview(self.dividerLabel)

    self.styleAliceLabel(label: self.aliceLabels.first!)
    self.styleUserLabel(label: self.userLabels.first!)

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

    self.nameLabel.text = "\(self.generalData!.user.givenName) \(self.generalData!.user.familyName)"
    self.ageLabel.text = "\(self.generalData!.age) yrs."
    self.sposeLabelValue.text = "Aleksandra"
    self.phoneLabelValue.text = "\(self.generalData!.phoneNumber)"
    self.emailLabelValue.text = "\(self.generalData!.email)"
    self.coverageLabelValue.text = "\(self.generalData!.sum)€"
    self.yearsOfProtectionLabelValue.text = "\(self.generalData!.period)"
    self.monthlyFeeValueLabel.text = "\(self.generalData!.price)€"
    self.addressLabel.text = "\(self.generalData!.address)"
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "toAdditionalQuestions" {
      let controller = segue.destination as! AdditionalQuestionsView
      controller.setData(generalData: self.generalData!)
    }
  }

  @IBAction func applyButtonPushed(_ sender: Any) {
    self.container2.isHidden = false
  }

  @IBAction func recordingButtonDown(_ sender: Any) {
    if self.readyForNextStep {
      self.performSegue(withIdentifier: "toAdditionalQuestions", sender: self)
      return
    }
    self.displayLink = CADisplayLink(target: self, selector: #selector(self.updateMeters))
    self.displayLink?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    self.waveView.isHidden = false
    self.model.discoverUserData(userInput: {
      userText, status in
      if userText.isEmpty {
        self.newAliceLabel().text = "I can't hear you, could you please repeat?"
      } else {
        let userLabel = self.userLabels.last!
        userLabel.text = userText
        self.scroolContainer.scrollRectToVisible(userLabel.frame, animated: true)
      }
    }, aliceResponse: {
      aliceText, fields in
      if fields.count > 0 {
        self.recordButton.setImage(UIImage(named: "icoTick"), for: .normal)
        let aliceLabel = self.newAliceLabel()
        if let occupation = fields[.occupation] {
          aliceLabel.text = "So, you are a \(occupation), lets continue!"
        }
        self.scroolContainer.scrollRectToVisible(aliceLabel.frame, animated: true)
        self.readyForNextStep = self.model.canContinue()
        return
      }
      if let t = aliceText {
        let aliceLabel = self.newAliceLabel()
        aliceLabel.text = t;
        self.scroolContainer.scrollRectToVisible(aliceLabel.frame, animated: true)
        self.newUserLabel()
      }
    })
  }

  @IBAction func recordingButtonTouchUp(_ sender: Any) {
    self.displayLink?.invalidate()
    self.waveView.isHidden = true
    self.model.stopRecording()
  }

  fileprivate func styleKeyLabel(label: UILabel) {
    label.font = UIFont.questionHeaderFontFont()
  }

  fileprivate func styleValueLabel(label: UILabel) {
    label.textColor = UIColor.dodgerBlueTwo
    label.font = UIFont.summaryValueFontFont()
  }

  fileprivate func styleAliceLabel(label: UILabel) {
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .left
    label.textColor = UIColor.darkishBlue
    label.font = UIFont.recordHelpMessageFont()
  }

  fileprivate func styleUserLabel(label: UILabel) {
    label.text = ""
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .right
    label.textColor = UIColor.charcoalGrey
    label.font = UIFont.userSpeechResponseFontFont()
  }

  fileprivate func newAliceLabel() -> UILabel {
    let label = newConversationLabel(topView: self.userLabels.last!, identation: .right)
    self.styleAliceLabel(label: label)
    self.aliceLabels.append(label)
    return label
  }

  fileprivate func newUserLabel() {
    let label = newConversationLabel(topView: self.aliceLabels.last!, identation: .left)
    self.styleUserLabel(label: label)
    self.userLabels.append(label)
  }

  enum Identation {
    case left
    case right
  }

  fileprivate func newConversationLabel(topView: UIView, identation: Identation) -> UILabel {
    let mainGuides = self.container2.layoutMarginsGuide
    let label = UILabel()
    self.scroolContainer.addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.heightAnchor.constraint(greaterThanOrEqualToConstant: 41).isActive = true
    label.topAnchor.constraint(equalTo: topView.layoutMarginsGuide.bottomAnchor, constant: 20).isActive = true
    if identation == .right {
      label.leadingAnchor.constraint(equalTo: mainGuides.leadingAnchor, constant: 20).isActive = true
      label.trailingAnchor.constraint(lessThanOrEqualTo: mainGuides.trailingAnchor, constant: -40).isActive = true
    } else {
      label.leadingAnchor.constraint(greaterThanOrEqualTo: mainGuides.leadingAnchor, constant: 40).isActive = true
      label.trailingAnchor.constraint(equalTo: mainGuides.trailingAnchor, constant: -20).isActive = true
    }
    label.bottomAnchor.constraint(equalTo: self.scroolContainer.layoutMarginsGuide.bottomAnchor, constant: 6)
    return label
  }

  func updateMeters() {
    let random = Double(arc4random_uniform(255))
    self.waveView.updateWithLevel(CGFloat(random.divided(by: 255)))
  }
}

//
//  PaymentView.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 22/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import UIKit

class WelcomeView: UIViewController, WithViewModel {
  typealias Model = WelcomeViewModel

  @IBOutlet weak var alianzLogo: UIImageView!
  @IBOutlet weak var container: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var aliceNameLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var welcomeButton: UIButton!
  @IBOutlet weak var overlay: UIView!
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var questionLable: UILabel!
  @IBOutlet weak var voiceAnimation: WaveformView!
  @IBOutlet weak var dividerLabel: UILabel!
  @IBOutlet weak var recordBackground: UILabel!
  @IBOutlet weak var recordButton: UIButton!

  fileprivate var displayLink: CADisplayLink?

  override func viewDidLoad() {
    self.overlay.isHidden = true
    self.container.layer.cornerRadius = 8
    self.container.clipsToBounds = true

    self.view.backgroundColor = UIColor.background
    self.titleLabel.textAlignment = .center
    self.aliceNameLabel.textAlignment = .center
    self.subtitleLabel.textAlignment = .center

    self.titleLabel.numberOfLines = 0
    self.titleLabel.lineBreakMode = .byWordWrapping
    self.titleLabel.font = UIFont.headerFontFont()
    self.aliceNameLabel.font = UIFont.aliceNameFontFont()
    self.subtitleLabel.font = UIFont.subtitleFontFont()
    self.subtitleLabel.textColor = UIColor.slate50

    self.welcomeButton.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 8)
    self.welcomeButton.setTitleColor(UIColor.white, for: .normal)
    self.welcomeButton.backgroundColor = UIColor.vividPurple
    self.welcomeButton.titleLabel!.font = UIFont.buttonFontFont()

    self.overlay.backgroundColor = UIColor.clear

    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.prominent)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.alpha = 0.9
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    blurEffectView.frame = CGRect(x: 0, y: 0,
                                  width: self.overlay.frame.width,
                                  height: self.overlay.frame.height - self.recordBackground.frame.height)
    self.overlay.addSubview(blurEffectView)
    self.overlay.addSubview(self.messageLabel)
    self.overlay.addSubview(self.questionLable)
    self.overlay.addSubview(self.voiceAnimation)
    self.overlay.addSubview(self.dividerLabel)

    self.messageLabel.numberOfLines = 0
    self.messageLabel.lineBreakMode = .byWordWrapping
    self.messageLabel.textColor = UIColor.darkishBlue
    self.messageLabel.font = UIFont.recordHelpMessageFont()

    self.questionLable.isHidden = true
    self.questionLable.numberOfLines = 0
    self.questionLable.lineBreakMode = .byCharWrapping
    self.questionLable.textColor = UIColor.darkishBlue
    self.questionLable.font = UIFont.recordHelpMessageFont()

    self.voiceAnimation.isHidden = true
    self.voiceAnimation.numberOfWaves = 4
    self.voiceAnimation.waveColor = UIColor.dodgerBlue
    self.voiceAnimation.backgroundColor = UIColor.clear

    self.dividerLabel.text = ""
    self.dividerLabel.backgroundColor = UIColor.dodgerBlue

    self.recordBackground.text = ""
    self.recordBackground.backgroundColor = UIColor.vividPurple

    self.recordButton.setTitle("", for: .normal)
    self.recordButton.layer.cornerRadius = 0.5 * self.recordButton.bounds.size.width
    self.recordButton.clipsToBounds = true
    self.recordButton.layer.borderWidth = 2
    self.recordButton.layer.borderColor = UIColor.white.cgColor
  }

  @IBAction func welcomeButtonTouchDown(_ sender: Any) {
    self.model.requestMicrophoneAccess(callback: {
      result in
      if result {
        DispatchQueue.main.async {
          self.alianzLogo.isHidden = true
          self.overlay.isHidden = false
        }
      }
    })
  }

  @IBAction func recordButtonTouchDown(_ sender: Any) {
    if self.questionLable.isHidden {
      self.recordButton.layer.borderColor = UIColor.vividPurple.cgColor
      self.messageLabel.text = ""
      self.messageLabel.textAlignment = .right
      self.messageLabel.textColor = UIColor.charcoalGrey
      self.messageLabel.font = UIFont.userSpeechResponseFontFont()
      self.displayLink = CADisplayLink(target: self, selector: #selector(self.updateMeters))
      self.displayLink?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
      self.voiceAnimation.isHidden = false
      self.model.startRecording(callback: {
        input, status in
        DispatchQueue.main.async {
          self.messageLabel.text = input
        }
      })
    } else {
      self.model.requestContactsAccess(callback: {
        status in
        if status {
          self.performSegue(withIdentifier: "toGeneralInfrmation", sender: self)
        }
      })
    }
  }

  @IBAction func recordButtonTOuchUpInside(_ sender: Any) {
    self.stopRecording()
  }
  
  @IBAction func recordButtonTouchUpOutside(_ sender: Any) {
    self.stopRecording()
  }

  fileprivate func stopRecording() {
    self.model.speak(text: self.questionLable.text!)
    self.displayLink?.invalidate()
    self.voiceAnimation.isHidden = true
    self.model.stopRecording()
    self.recordButton.layer.borderColor = UIColor.white.cgColor
    self.questionLable.isHidden = false
    self.recordButton.setImage(UIImage(named: "icoTick"), for: .normal)
  }

  func updateMeters() {
    let random = Double(arc4random_uniform(255))
    self.voiceAnimation.updateWithLevel(CGFloat(random.divided(by: 255)))
  }
}

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

  @IBOutlet weak var container: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var aliceNameLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var welcomeButton: UIButton!

  override func viewDidLoad() {
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
    self.welcomeButton.titleLabel!.font = UIFont.hiButtonFontFont()
  }
}

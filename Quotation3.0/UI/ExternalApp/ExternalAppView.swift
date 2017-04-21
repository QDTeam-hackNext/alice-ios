//
//  ExternalAppView.swift
//  Alice
//
//  Created by Dariusz Łuksza on 21/04/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import UIKit
import Foundation

class ExternalAppView: UIView {
  @IBOutlet var contentView: UIView!

  @IBOutlet weak var icon: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var discountLabel: UILabel!
  @IBOutlet weak var toggleSwitch: UISwitch!

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.commonInit()
  }

  fileprivate func commonInit() {
    Bundle.main.loadNibNamed("ExternalAppView", owner: self, options: [:])

    self.contentView.frame = self.bounds
    self.backgroundColor = UIColor.clear
    self.contentView.backgroundColor = UIColor.clear
    self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.contentView.translatesAutoresizingMaskIntoConstraints = true

    self.nameLabel.font = UIFont.sumaryNameFontFont()
    self.nameLabel.textColor = UIColor.slate

    self.discountLabel.isHidden = true
    self.discountLabel.textColor = UIColor.green
    self.discountLabel.font = UIFont.appDiscountFontFont()

    self.toggleSwitch.setOn(false, animated: false)

    self.addSubview(self.contentView)
  }
}

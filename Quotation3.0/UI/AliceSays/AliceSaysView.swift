//
//  AliceSays.swift
//  Alice
//
//  Created by Dariusz Łuksza on 21/04/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import UIKit
import Foundation

class AliceSaysView: UIView {
  @IBOutlet var contentView: UIView!

  @IBOutlet weak var text: UILabel!

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.commonInit()
  }

  fileprivate func commonInit() {
    Bundle.main.loadNibNamed("AliceSaysView", owner: self, options: [:])

    self.contentView.frame = self.bounds
    self.backgroundColor = UIColor.clear
    self.contentView.backgroundColor = UIColor.clear
    self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.contentView.translatesAutoresizingMaskIntoConstraints = true

    self.text.numberOfLines = 0
    self.text.lineBreakMode = .byWordWrapping
    self.text.textColor = UIColor.charcoalGrey
    self.text.font = UIFont.aliceMessageFontFont()?.withSize(19)

    self.addSubview(self.contentView)
  }
}

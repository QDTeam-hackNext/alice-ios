//
//  InformationRowView.swift
//  Alice
//
//  Created by Dariusz Łuksza on 22/04/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import UIKit
import Foundation

class InformationRowView: UIView {
  @IBOutlet var contentView: UIView!

  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var value: UILabel!

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.commonInit()
  }

  fileprivate func commonInit() {
    Bundle.main.loadNibNamed("InformationRowView", owner: self, options: [:])

    self.backgroundColor = UIColor.clear
    self.contentView.frame = self.bounds
    self.contentView.backgroundColor = UIColor.clear
    self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.contentView.translatesAutoresizingMaskIntoConstraints = true

    self.name.textAlignment = .left
    self.name.font = UIFont.sumaryNameFontFont()
    self.name.textColor = UIColor.slate

    self.value.textAlignment = .right
    self.value.font = UIFont.summaryValueFontFont()
    self.value.textColor = UIColor.dodgerBlueTwo

    self.addSubview(self.contentView)
  }
}

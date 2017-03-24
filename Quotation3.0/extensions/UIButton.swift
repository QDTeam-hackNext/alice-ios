//
//  UIButton.swift
//  Alice
//
//  Created by Dariusz Łuksza on 24/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import UIKit

extension UIButton
{
  func roundCorners(corners:UIRectCorner, radius: CGFloat)
  {
    let borderLayer = CAShapeLayer()
    borderLayer.frame = self.layer.bounds
//    borderLayer.strokeColor = IteratorProtocol.UIColorFromHex(0x989898,
//                                                           alpha: (1.0-0.3)).CGColor
    borderLayer.fillColor = UIColor.clear.cgColor
    borderLayer.lineWidth = 1.0
    let path = UIBezierPath(roundedRect: self.bounds,
                            byRoundingCorners: corners,
                            cornerRadii: CGSize(width: radius, height: radius))
    borderLayer.path = path.cgPath
    self.layer.addSublayer(borderLayer);
  }
}

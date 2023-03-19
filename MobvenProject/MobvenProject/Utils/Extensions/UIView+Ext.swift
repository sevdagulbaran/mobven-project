//
//  UIView+Ext.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 13.03.2023.
//

import UIKit

extension UIView {
    
  public func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}


//
//  UIView+Ext.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 13.03.2023.
//

import UIKit

extension UIView {
    
    // MARK: - Round Specific Corners
    
    func roundCorner(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}

//
//  Color+Ext.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 11.03.2023.
//

import UIKit

extension UIColor {
    
    static let blueLight = UIColor(named: "Blue-Light")
    static let blueDark = UIColor(named: "Blue-Dark")
    static let customBlue = UIColor(named: "Blue")
    static let customGreen = UIColor(named: "Green")
    static let lime = UIColor(named: "Lime")
    static let customOrange = UIColor(named: "Orange")
    static let purpleLight = UIColor(named: "Purple-Light")
    static let purpleSoft = UIColor(named: "Purple-Soft")
    static let customPurple = UIColor(named: "Purple")
    static let customRed = UIColor(named: "Red")
    static let skyBlue = UIColor(named: "Sky-Blue")
    static let customWhite = UIColor(named: "White")
    static let customYellow = UIColor(named: "Yellow")
    
    static var gradientColor: UIColor {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, 0.0)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIColor(patternImage: image!)
    }
}

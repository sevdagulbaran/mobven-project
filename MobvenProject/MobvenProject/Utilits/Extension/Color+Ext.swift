//
//  Color+Ext.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 11.03.2023.
//

import UIKit

extension UIColor {
    
    class func rgb(fromHex: Int) -> UIColor {
        
        let red =   CGFloat((fromHex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((fromHex & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(fromHex & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public static let blueDark: UIColor = {
        
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return rgb(fromHex: 0xE5E3FC)
                } else {
                    return rgb(fromHex: 0x1A1167)
                }
            }
        } else {
            return rgb(fromHex: 0x5E3FC)
        }
    }()
}

//
//  UIImageView+Ext.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 17.03.2023.
//

import UIKit

extension UIImageView {
    
    func loadFrom(stringURL: String) {
        guard let url = URL(string: stringURL) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}

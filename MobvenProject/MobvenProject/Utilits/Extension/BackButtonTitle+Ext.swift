//
//  BackButton+Ext.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 12.03.2023.
//

import UIKit

extension UIViewController {
    func configureBackButtonTitle(_ title: String) {
        navigationItem.backButtonTitle = title
        navigationController?.navigationBar.tintColor = UIColor.blueDark
    }
}

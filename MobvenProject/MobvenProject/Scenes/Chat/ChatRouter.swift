//
//  ChatRouter.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 11.04.2023.
//

import UIKit
import PhotosUI

protocol ChatRoutingLogic: AnyObject {
    func showMedia()
    func backToHome()
    
}

protocol ChatDataPassing: AnyObject {
    var dataStore: ChatDataStore? { get }
}

final class ChatRouter: ChatRoutingLogic, ChatDataPassing {
    
    weak var viewController: ChatViewController?
    var dataStore: ChatDataStore?
    
    private func routeToPHPicker(filter: PHPickerFilter) {
        var config = PHPickerConfiguration()
        config.selectionLimit = 10
        config.filter = filter
        let pickerViewController = PHPickerViewController(configuration: config)
        pickerViewController.delegate = viewController
        viewController?.present(pickerViewController, animated: true)
    }
    
    func showMedia() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Photo", style: .default) { [weak self] _ in
            self?.routeToPHPicker(filter: .images)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        viewController?.present(alert, animated: true)
    }
    
    func backToHome() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}

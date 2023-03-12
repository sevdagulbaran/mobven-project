//
//  UIViewController+Ext.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 12.03.2023.
//

import UIKit

extension UIViewController {
    
    //MARK: Configure BackButton
    
    func configureBackButtonTitle(_ title: String) {
        navigationItem.backButtonTitle = title
        navigationController?.navigationBar.tintColor = UIColor.blueDark
    }
    
    //MARK: Hide Keyboard when tapped around
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: Show-Hide Keyboard
    
    @objc func keyboardWillShow(sender: NSNotification) {
        //frame will be added in
        view.frame.origin.y = view.frame.origin.y - 200
    }
        
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

//
//  WelcomeViewController.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 10.03.2023.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var modeSwitch: UISwitch!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButtonTitle("")
        storedMode()
    }
    
    // MARK: - Private Methods
    
    private func storedMode() {
        let mode = UserDefaults.standard.string(forKey: "appMode")
        if mode == "dark" {
            overrideUserInterfaceStyle = .dark
            modeSwitch.setOn(true, animated: false)
        } else {
            overrideUserInterfaceStyle = .light
            modeSwitch.setOn(false, animated: false)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(interfaceStyleChanged), name: UIAccessibility.reduceTransparencyStatusDidChangeNotification, object: nil)
    }
    
    //MARK: - Actions
    
    @IBAction private func changeModeTapped(_ sender: UISwitch) {
        if sender.isOn {
            overrideUserInterfaceStyle = .dark
            UserDefaults.standard.setValue("dark", forKey: "appMode")
        } else {
            overrideUserInterfaceStyle = .light
            UserDefaults.standard.setValue("light", forKey: "appMode")
        }
    }
    
    @IBAction private func goToSignIn(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction private func goToSignUp(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else {
            return
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    //MARK: - Notification
    
    @objc  func interfaceStyleChanged() {
        let mode = UserDefaults.standard.string(forKey: "appMode")
        if mode == "dark" {
            modeSwitch.setOn(true, animated: true)
        } else {
            modeSwitch.setOn(false, animated: true)
        }
    }
}

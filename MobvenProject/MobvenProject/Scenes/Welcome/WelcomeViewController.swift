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
        
    }
    
    //MARK: - Actions
    
    @IBAction private func changeModeTapped(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "isMode")
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let windows = windowScene.windows
            for window in windows {
                if window.traitCollection.userInterfaceStyle == .dark {
                    sender.isOn = false
                } else {
                    sender.isOn = true
                }
                window.overrideUserInterfaceStyle = sender.isOn ? .dark : .light
            }
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
}

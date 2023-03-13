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
        setupUI()
        storedMode()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        configureBackButtonTitle("")
    }
    
    private func storedMode() {
        guard let isMode = UserDefaults.standard.object(forKey: "isDarkMode") as? Bool else { return }
        modeSwitch.isOn = isMode
    }
    
    //MARK: - Actions
    
    @IBAction private func changeModeTapped(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "isDarkMode")
        if let windowScene = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).first,
           let window = windowScene?.windows.first {
            window.overrideUserInterfaceStyle = sender.isOn ? .dark: .light
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

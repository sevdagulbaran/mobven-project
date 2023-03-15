//
//  WelcomeRouter.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 15.03.2023.
//

import UIKit

protocol WelcomeRoutingLogic: AnyObject {
    func goToSignIn()
    func goToSignUp()
}

protocol WelcomeDataPassing: AnyObject {
    var dataStore: WelcomeDataStore? { get }
}

final class WelcomeRouter: WelcomeRoutingLogic, WelcomeDataPassing {
    
    weak var viewController: WelcomeViewController?
    var dataStore: WelcomeDataStore?
    
    func goToSignIn() {
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        
        guard let destinationViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return
        }
        viewController?.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    func goToSignUp() {
        let storyBoard = UIStoryboard(name: "Register", bundle: nil)
        
        guard let destinationViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else {
            return
        }
        viewController?.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}

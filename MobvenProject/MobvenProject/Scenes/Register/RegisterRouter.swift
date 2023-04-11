//
//  RegisterRouter.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 15.03.2023.
//

import UIKit

protocol RegisterRoutingLogic: AnyObject {
    func goToLogin()
}

protocol RegisterDataPassing: AnyObject {
    var dataStore: RegisterDataStore? { get }
}

final class RegisterRouter: RegisterRoutingLogic, RegisterDataPassing {
    
    weak var viewController: RegisterViewController?
    var dataStore: RegisterDataStore?
    
    func goToLogin() {
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        
        guard let destinationViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return
        }
        viewController?.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
}

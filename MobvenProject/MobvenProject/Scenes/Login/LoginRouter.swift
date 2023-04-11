//
//  LoginRouter.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 15.03.2023.
//

import UIKit

protocol LoginRoutingLogic: AnyObject {
    func goToHome()
}

protocol LoginDataPassing: AnyObject {
    var dataStore: LoginDataStore? { get }
}

final class LoginRouter: LoginRoutingLogic, LoginDataPassing {
    
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?

    func goToHome() {
        
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        guard let destinationViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return }
        destinationViewController.router?.dataStore?.authorizedPerson = dataStore?.loginResponse?.body
        
        viewController?.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}

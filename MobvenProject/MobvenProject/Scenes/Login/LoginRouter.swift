//
//  LoginRouter.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 15.03.2023.
//

import UIKit

protocol LoginRoutingLogic: AnyObject {
    func goToVerify()
}

protocol LoginDataPassing: AnyObject {
    var dataStore: LoginDataStore? { get }
}

final class LoginRouter: LoginRoutingLogic, LoginDataPassing {
    
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    func goToVerify() {
        let storyBoard = UIStoryboard(name: "Verify", bundle: nil)
        
        guard let destinationViewController = storyBoard.instantiateViewController(withIdentifier: "VerifyViewController") as? VerifyViewController else { return }
        
        viewController?.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}

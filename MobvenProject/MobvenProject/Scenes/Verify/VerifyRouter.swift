//
//  VerifyRouter.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 15.03.2023.
//

import Foundation
import UIKit

protocol VerifyRoutingLogic: AnyObject {
    func goToHome()
}

protocol VerifyDataPassing: class {
    var dataStore: VerifyDataStore? { get }
}

final class VerifyRouter: VerifyRoutingLogic, VerifyDataPassing {
    
    weak var viewController: VerifyViewController?
    var dataStore: VerifyDataStore?
    
    func goToHome() {
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        
        guard let destinationViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return }
        
        viewController?.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}

//
//  HomeRouter.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 16.03.2023.
//

import UIKit

protocol HomeRoutingLogic: AnyObject {
    func goToProfile()
    func goToChat()
}

protocol HomeDataPassing: AnyObject {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: HomeRoutingLogic, HomeDataPassing {
    
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
    func goToProfile() {
        
        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
        guard let destinationViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else { return }
        
        viewController?.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    func goToChat() {
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        guard let destinationViewController = storyboard.instantiateViewController(
            withIdentifier: "ChatViewController"
        ) as? ChatViewController else { return }
        viewController?.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}

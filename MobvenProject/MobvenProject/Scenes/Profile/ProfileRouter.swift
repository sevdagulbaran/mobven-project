//
//  ProfileRouter.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 10.04.2023.
//

import Foundation
import UIKit

protocol ProfileRoutingLogic: AnyObject {
    func goToWebView(url: URL?)
}

protocol ProfileDataPassing: class {
    var dataStore: ProfileDataStore? { get }
}

final class ProfileRouter: ProfileRoutingLogic, ProfileDataPassing {
    
    weak var viewController: ProfileViewController?
    var dataStore: ProfileDataStore?
    
    func goToWebView(url: URL?) {
        let storyBoard = UIStoryboard(name: "WebView", bundle: nil)
        guard let destinationViewController = storyBoard.instantiateViewController(withIdentifier: "WebViewViewController") as? WebViewViewController else { return }
        
        viewController?.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
}

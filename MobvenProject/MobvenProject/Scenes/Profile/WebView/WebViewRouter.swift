//
//  WebViewRouter.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 10.04.2023.
//

import Foundation

protocol WebViewRoutingLogic: AnyObject {
    
}

protocol WebViewDataPassing: class {
    var dataStore: WebViewDataStore? { get }
}

final class WebViewRouter: WebViewRoutingLogic, WebViewDataPassing {
    
    weak var viewController: WebViewViewController?
    var dataStore: WebViewDataStore?
    
}

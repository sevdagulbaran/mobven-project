//
//  HomeRouter.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 16.03.2023.
//

import Foundation

protocol HomeRoutingLogic: AnyObject {
    
}

protocol HomeDataPassing: AnyObject {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: HomeRoutingLogic, HomeDataPassing {
    
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
}

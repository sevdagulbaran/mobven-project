//
//  VerifyRouter.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 15.03.2023.
//

import Foundation

protocol VerifyRoutingLogic: AnyObject {
    
}

protocol VerifyDataPassing: class {
    var dataStore: VerifyDataStore? { get }
}

final class VerifyRouter: VerifyRoutingLogic, VerifyDataPassing {
    
    weak var viewController: VerifyViewController?
    var dataStore: VerifyDataStore?
    
}

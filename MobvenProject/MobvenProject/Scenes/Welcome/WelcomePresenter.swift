//
//  WelcomePresenter.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 15.03.2023.
//

import Foundation

protocol WelcomePresentationLogic: AnyObject {
    
}

final class WelcomePresenter: WelcomePresentationLogic {
    
    weak var viewController: WelcomeDisplayLogic?
    
}

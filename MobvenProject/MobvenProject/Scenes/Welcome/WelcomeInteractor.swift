//
//  WelcomeInteractor.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 15.03.2023.
//

import Foundation

protocol WelcomeBusinessLogic: AnyObject {
    
}

protocol WelcomeDataStore: AnyObject {
    
}

final class WelcomeInteractor: WelcomeBusinessLogic, WelcomeDataStore {
    
    var presenter: WelcomePresentationLogic?
    var worker: WelcomeWorkingLogic = WelcomeWorker()
    
}

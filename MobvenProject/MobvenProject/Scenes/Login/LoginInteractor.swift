//
//  LoginInteractor.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 15.03.2023.
//

import Foundation

protocol LoginBusinessLogic: AnyObject {
    
}

protocol LoginDataStore: AnyObject {
    
}

final class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    
    var presenter: LoginPresentationLogic?
    var worker: LoginWorkingLogic = LoginWorker()
    
}

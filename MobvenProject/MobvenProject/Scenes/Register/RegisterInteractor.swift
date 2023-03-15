//
//  RegisterInteractor.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 15.03.2023.
//

import Foundation

protocol RegisterBusinessLogic: AnyObject {
    
}

protocol RegisterDataStore: AnyObject {
    
}

final class RegisterInteractor: RegisterBusinessLogic, RegisterDataStore {
    
    var presenter: RegisterPresentationLogic?
    var worker: RegisterWorkingLogic = RegisterWorker()
    
}

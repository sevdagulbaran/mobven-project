//
//  VerifyInteractor.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 15.03.2023.
//

import Foundation

protocol VerifyBusinessLogic: AnyObject {
    
}

protocol VerifyDataStore: AnyObject {
    
}

final class VerifyInteractor: VerifyBusinessLogic, VerifyDataStore {
    
    var presenter: VerifyPresentationLogic?
    var worker: VerifyWorkingLogic = VerifyWorker()
    
}

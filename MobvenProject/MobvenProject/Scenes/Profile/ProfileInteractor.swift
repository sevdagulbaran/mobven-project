//
//  ProfileInteractor.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 10.04.2023.
//

import Foundation

protocol ProfileBusinessLogic: AnyObject {
    
}

protocol ProfileDataStore: AnyObject {
    
}

final class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    
    var presenter: ProfilePresentationLogic?
    var worker: ProfileWorkingLogic = ProfileWorker()
    
}

//
//  HomeInteractor.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 16.03.2023.
//

import Foundation

protocol HomeBusinessLogic: AnyObject {
    
}

protocol HomeDataStore: AnyObject {
    
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    var presenter: HomePresentationLogic?
    var worker: HomeWorkingLogic = HomeWorker()
    
}

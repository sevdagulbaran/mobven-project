//
//  HomeInteractor.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 16.03.2023.
//

import Foundation

protocol HomeBusinessLogic: AnyObject {
    func fetchGroupsData()
    
}

protocol HomeDataStore: AnyObject {
    var groups: [AllGroupsResponse.Group]? { get set }
    var authorizedPerson: LoginResponse.Body? { get set }
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    var presenter: HomePresentationLogic?
    var worker: HomeWorkingLogic = HomeWorker()
    var groups: [AllGroupsResponse.Group]?
    var authorizedPerson: LoginResponse.Body?
    
    func fetchGroupsData() {
        guard let authorizedPerson = authorizedPerson else { return }
        worker.fetchAllGroups(token: authorizedPerson.accessToken) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let allGroupResponse):
                self.groups = allGroupResponse.body.groups
                guard let groups = self.groups else { return }
                self.presenter?.presentGroups(response: groups)
            case .failure(let error):
                self.presenter?.presentErrorMessage(errorMessage: error.localizedDescription)
            }
        }
    }
}

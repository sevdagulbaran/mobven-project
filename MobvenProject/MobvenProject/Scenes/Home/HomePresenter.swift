//
//  HomePresenter.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 16.03.2023.
//

import Foundation

protocol HomePresentationLogic: AnyObject {
    func presentGroups(response: [AllGroupsResponse.Group])
    func presentErrorMessage(errorMessage: String)
}

final class HomePresenter: HomePresentationLogic {
    
    weak var viewController: HomeDisplayLogic?
    
    func presentGroups(response: [AllGroupsResponse.Group]) {
        var userViewModels: [Groups.Fetch.ViewModel.User] = []
        
        response.forEach { group in
            let users = group.users.map({ user in
                
                let userViewModel = Groups.Fetch.ViewModel.User(nameSurname: user.nameSurname,
                                                             profilePhoto: user.profilePhoto,
                                                             title: user.title)
                print(userViewModel)
                userViewModels.append(userViewModel)
                return userViewModel
            })
        }
        self.viewController?.displayUsers(userViewModels: userViewModels)
        
    }
    
    func presentErrorMessage(errorMessage: String) {
        viewController?.displayErrorMessage("Failed to fetch data")
    }
}

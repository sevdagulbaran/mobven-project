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
        
        var groupsViewModels: [Groups.Fetch.ViewModel.Group] = []
        
        response.forEach { group in
            let users = group.users.map({ user in
                
                return Groups.Fetch.ViewModel.User(nameSurname: user.nameSurname,
                                                   profilePhoto: user.profilePhoto,
                                                   title: user.title)
                
                
            })
            
            let lastMessage = Groups.Fetch.ViewModel.LastMessage(
                fromUsername: group.lastMessage?.from.nameSurname ?? "",
                message: group.lastMessage?.message ?? "")
            
            groupsViewModels.append(Groups.Fetch.ViewModel.Group(name: group.name ,
                                                                 groupPhoto: group.groupPhoto,
                                                                 users: users,
                                                                 lastMessage: lastMessage))
        }
        self.viewController?.displayGroups(groupViewModels: groupsViewModels)
        
    }
    
    func presentErrorMessage(errorMessage: String) {
        viewController?.displayErrorMessage("Failed to fetch data")
    }
}

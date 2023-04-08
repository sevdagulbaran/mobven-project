//
//  HomeModels.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 16.03.2023.
//

import Foundation

// swiftlint:disable nesting
enum Groups {
    
    enum Fetch {
        
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
            struct Group {
                let name: String
                let groupPhoto: String?
                let users: [User]?
                let lastMessage: LastMessage?
            }
            
            struct User {
                let nameSurname: String
                let profilePhoto: String?
                let title: String
            }
            
            struct LastMessage {
                let fromUsername: String
                let message: String
            }
        }
    }
}
// swiftlint:enable nesting

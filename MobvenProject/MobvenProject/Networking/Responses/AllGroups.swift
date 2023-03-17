//
//  AllGroups.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 16.03.2023.
//

import Foundation

public struct AllGroupsResponse: Codable {
    public let body: Body
    public let reason: String
    public let error: Bool
    
    // MARK: - Body
    
    public struct Body: Codable {
        public let groups: [Group]
        public let pagination: Pagination
    }
    
    // MARK: - Group
    
    public struct Group: Codable {
        public let id: String
        public let name: String
        public let createdAt: String
        public let users: [User]
        public let updatedAt: String
        public let lastMessage: LastMessage?
    }
    
    // MARK: - LastMessage
    
    public struct LastMessage: Codable {
        public let id: String
        public let updatedAt: String
        public let createdAt: String
        public let message: String
        public let to: To
        public let from: User
    }
    
    // MARK: - User
    
    public struct User: Codable {
        public let id: String
        public let email: String
        public let nameSurname: String
        public let title: String
        public let profilePhoto: String?
        public let updatedAt: String
        public let createdAt: String
    }
    
    // MARK: - To
    public struct To: Codable {
        public let id: String
        public let name: String
        public let groupPhoto: String?
        public let updatedAt: String
        public let deletedAt: String?
        public let createdAt: String
    }
    
    // MARK: - Pagination
    public struct Pagination: Codable {
        public let per, total,page: Int
    }
}

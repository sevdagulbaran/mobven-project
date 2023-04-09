//
//  Login.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 9.04.2023.
//

import Foundation
// MARK: - LoginResponse

public struct LoginResponse: Codable {
    public let error: Bool
    public let reason: String
    public let body: Body?

    // MARK: - Body
    
    public struct Body: Codable {
        public let id: String
        public let nameSurname: String
        public let title: String
        public let profilePhoto: String?
        public let accessToken: String
        public let refreshToken: String
        public let email: String
        public let phoneNumber: String?
        public let pushNotificationToken: String?
        public let pushNotificationEnabled: Bool
        public let team: Team?
    }

    // MARK: - Team
    public struct Team: Codable {
        public let createdAt: String
        public let id: String
        public let updatedAt: String?
        public let deletedAt: String?
        public let name: String
        public let company: Company?
    }

    // MARK: - Company
    public struct Company: Codable {
        public let id: String
    }
}

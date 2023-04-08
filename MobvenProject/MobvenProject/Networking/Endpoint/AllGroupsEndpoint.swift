//
//  AllGroupsEndpoint.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 16.03.2023.
//

import Foundation

public enum AllGroupsEndpoint {
    case allGroups
}

extension AllGroupsEndpoint: Endpoint {
    
    public var path: String {
        switch self {
        case .allGroups:
            return NetworkConstants.PATH
        }
    }
    
    public var method: RequestMethod {
        return .get
    }
    
    public var header: [String : String]? {
        switch self {
        case .allGroups:
            return [
                "Authorization": "Bearer \(NetworkConstants.AccessToken)",
                //"Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    public var body: [String : String]? {
        switch self {
        case .allGroups:
            return nil
        }
    }
    
    public var queryItems: [URLQueryItem]? {
       return [URLQueryItem(name: "page", value: "1"), URLQueryItem(name: "per", value: "5")]
    }
}

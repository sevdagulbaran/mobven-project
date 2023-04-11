//
//  AllGroupsEndpoint.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 16.03.2023.
//

import Foundation

public enum AllGroupsEndpoint {
    case allGroups(token: String)
}

extension AllGroupsEndpoint: Endpoint {
    
    public var path: String {
            return NetworkConstants.PathGroup
    }
    
    public var method: RequestMethod {
        return .get
    }
    
    public var header: [String : String]? {
        switch self {
        case .allGroups(let token):
            return [
                "Authorization": "Bearer \(token)",
            ]
        }
    }
    
    public var body: [String : String]? {
            return nil
    }
    
    public var queryItems: [URLQueryItem]? {
       return [URLQueryItem(name: "page", value: "1"), URLQueryItem(name: "per", value: "5")]
    }
}

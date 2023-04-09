//
//  LoginEndpoint.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 9.04.2023.
//

import Foundation
import UIKit

public enum LoginEndpoint {
    case login(username: String, password: String)
}

extension LoginEndpoint: Endpoint {
    public var method: RequestMethod {
        return .post
    }

    public var path: String {
        return NetworkConstants.PathLogin
    }

    public var queryItems: [URLQueryItem]? {
        return nil
    }

    public var body: [String : String]? {
        return nil
    }

    public var header: [String : String]? {
        guard case .login(let username, let password) = self else { return nil }
        
        let authString = String(format: "%@:%@", username, password)
        let authData = (authString.data(using: .utf8)!.base64EncodedString())
        let authorizationHeader = ["Authorization": "Basic \(authData)"]

        let deviceIdHeader = ["X-Device-Id": UIDevice.current.identifierForVendor?.uuidString ?? ""]
        let platformHeader = ["X-Platform": "iOS"]
        let deviceNameHeader = ["X-Device-Name": UIDevice.current.name]
        let pushNotificationTokenHeader = ["X-Push-Notification-Token": "1234567890"]

        return authorizationHeader
               .merging(deviceIdHeader, uniquingKeysWith: { $1 })
               .merging(platformHeader, uniquingKeysWith: { $1 })
               .merging(deviceNameHeader, uniquingKeysWith: { $1 })
               .merging(pushNotificationTokenHeader, uniquingKeysWith: { $1 })

    }
}

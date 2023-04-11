//
//  Endpoint.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 14.03.2023.
//

import Foundation

public protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var port: Int { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
    public var scheme: String {
        return "http"
    }

    public var host: String {
        return "momentumv2.mobven.com"
    }
    
    public var port: Int {
        return 7076
    }
}

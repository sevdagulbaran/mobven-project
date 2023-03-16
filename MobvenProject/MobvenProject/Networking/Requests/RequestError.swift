//
//  RequestError.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 13.03.2023.
//


public enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .invalidURL:
            return "InvalidURL error"
        case .noResponse:
            return "No Response"
        case .unauthorized:
            return "Session expired"
        case .unexpectedStatusCode:
            return "Unexpected Status Code error"
        default:
            return "Unknown error"
        }
    }
}

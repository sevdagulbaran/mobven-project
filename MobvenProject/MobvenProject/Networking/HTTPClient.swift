//
//  HTTPClient.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 14.03.2023.
//

import Foundation

public protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint,
                                   responseModel: T.Type,
                                   completion: @escaping (Result<T, RequestError>) -> Void)
}

public extension HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type,
        completion: @escaping (Result<T,RequestError>) -> Void
    ) {
        
        let urlComponents = prepareURLComponents(with: endpoint)
        
        guard let url = urlComponents.url else {
            return completion(.failure(.invalidURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            do {
                guard let response = response as? HTTPURLResponse else {
                    return completion(.failure(.noResponse))
                }
                switch response.statusCode {
                case 200...299:
                    let decodedResponse = try JSONDecoder().decode(responseModel, from: data!)
                    return completion(.success(decodedResponse))
                case 401:
                    return completion(.failure(.unauthorized))
                default:
                    return completion(.failure(.unexpectedStatusCode))
                }
            } catch {
                return completion(.failure(.unknown))
            }
        }
        .resume()
    }
    
    private func prepareURLComponents(
        with endpoint: Endpoint
    ) -> URLComponents {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.port = endpoint.port
        
        if let queryItems = endpoint.queryItems {
            urlComponents.queryItems = queryItems
        }
        
        return urlComponents
    }
}

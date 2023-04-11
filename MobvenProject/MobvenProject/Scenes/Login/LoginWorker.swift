//
//  LoginWorker.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 15.03.2023.
//

import Foundation

protocol LoginWorkingLogic: AnyObject {
    func getLogin(email: String, password: String, completion: @escaping ((Result<LoginResponse, RequestError>) -> Void))
}

final class LoginWorker: LoginWorkingLogic, HTTPClient {
    
    func getLogin(email: String, password: String, completion: @escaping ((Result<LoginResponse, RequestError>) -> Void)) {
        sendRequest(endpoint: LoginEndpoint.login(username: email, password: password), responseModel: LoginResponse.self, completion: completion)
    }
}

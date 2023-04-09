//
//  HomeWorker.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 16.03.2023.
//

import Foundation

protocol HomeWorkingLogic: AnyObject {
    func fetchAllGroups(token: String, completion: @escaping ((Result<AllGroupsResponse, RequestError>) -> ()))
}

final class HomeWorker: HomeWorkingLogic,HTTPClient {
    func fetchAllGroups(token: String, completion: @escaping ((Result<AllGroupsResponse, RequestError>) -> ())) {
        sendRequest(endpoint: AllGroupsEndpoint.allGroups(token: token), responseModel: AllGroupsResponse.self) { result in
               switch result {
               case .success(let response):
                   completion(.success(response))
               case .failure(let error):
                   completion(.failure(error))
               }
           }
       }
}

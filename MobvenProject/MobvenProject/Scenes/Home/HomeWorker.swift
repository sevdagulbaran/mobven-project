//
//  HomeWorker.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 16.03.2023.
//

import Foundation

protocol HomeWorkingLogic: AnyObject {
    func fetchAllGroups(completion: @escaping ((Result<AllGroupsResponse, RequestError>) -> ()))
}

final class HomeWorker: HomeWorkingLogic,HTTPClient {
    func fetchAllGroups(completion: @escaping ((Result<AllGroupsResponse, RequestError>) -> ())) {
           sendRequest(endpoint: AllGroupsEndpoint.allGroups, responseModel: AllGroupsResponse.self) { result in
               switch result {
               case .success(let response):
                   completion(.success(response))
               case .failure(let error):
                   completion(.failure(error))
               }
           }
       }
}

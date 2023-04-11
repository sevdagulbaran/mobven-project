//
//  LoginModels.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 15.03.2023.
//

import Foundation


enum Login {

    enum Fetch {

        struct Request {

        }

        struct Response {
            let loginResponse: LoginResponse
        }

        struct ViewModel {
            let nameSurname: String
            let email: String
            let accessToken: String
        }
    }
}

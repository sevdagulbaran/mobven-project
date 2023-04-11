//
//  LoginInteractor.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 15.03.2023.
//
import Foundation

protocol LoginBusinessLogic: AnyObject {
    func login(email: String, password: String)
}

protocol LoginDataStore: AnyObject {
    var loginResponse: LoginResponse? { get set }
}

final class LoginInteractor: LoginBusinessLogic, LoginDataStore {

    var presenter: LoginPresentationLogic?
    var worker: LoginWorkingLogic = LoginWorker()
    var loginResponse: LoginResponse?

    func login(email: String, password: String) {
        worker.getLogin(email: email, password: password) { result in
            switch result {
            case .success(let response):
                self.loginResponse = response
                guard let loginResponse = self.loginResponse else { return }
                self.presenter?.presentLogin(response: Login.Fetch.Response(loginResponse: loginResponse))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

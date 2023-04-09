//
//  LoginPresenter.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 15.03.2023.
//

import Foundation

protocol LoginPresentationLogic: AnyObject {
    func presentLogin(response: Login.Fetch.Response)
}

final class LoginPresenter: LoginPresentationLogic {

    weak var viewController: LoginDisplayLogic?
    func presentLogin(response: Login.Fetch.Response) {
        let authorized = response.loginResponse.body
        let authorizedPerson = Login.Fetch.ViewModel(
            nameSurname: authorized?.nameSurname ?? "name",
            email: authorized?.email ?? "email",
            accessToken: authorized?.accessToken ?? "token")

        viewController?.displayAuthorizedPerson(viewModel: authorizedPerson)
    }

}

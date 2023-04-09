//
//  ProfileViewController.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 9.04.2023.
//

import UIKit
import WebKit

protocol ProfileDisplayLogic: AnyObject {
    
}

final class ProfileViewController: UIViewController {
    
    // MARK: Property
    
    var interactor: ProfileBusinessLogic?
    var router: (ProfileRoutingLogic & ProfileDataPassing)?
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    @IBAction func openLinkedinButtonTapped(_ sender: Any) {
        let url = URL(string: "https://www.linkedin.com/in/sevdagulbaran")
        router?.goToWebView(url: url)
    }
}

extension ProfileViewController: ProfileDisplayLogic {
    
}

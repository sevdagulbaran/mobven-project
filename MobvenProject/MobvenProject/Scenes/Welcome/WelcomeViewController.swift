//
//  WelcomeViewController.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 10.03.2023.
//

import UIKit

protocol WelcomeDisplayLogic: AnyObject {
    
}

final class WelcomeViewController: UIViewController, WelcomeDisplayLogic {
    
    var interactor: WelcomeBusinessLogic?
    var router: (WelcomeRoutingLogic & WelcomeDataPassing)?
    
    // MARK: - Properties
    
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var modeSwitch: UISwitch!
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        storedMode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = WelcomeInteractor()
        let presenter = WelcomePresenter()
        let router = WelcomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        configureBackButtonTitle("")
    }
    
    private func storedMode() {
        guard let isMode = UserDefaults.standard.object(forKey: "isDarkMode") as? Bool else { return }
        modeSwitch.isOn = isMode
    }
    
    //MARK: - Actions
    
    @IBAction private func changeModeTapped(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "isDarkMode")
        if let windowScene = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).first,
           let window = windowScene?.windows.first {
            window.overrideUserInterfaceStyle = sender.isOn ? .dark: .light
        }
    }
    
    @IBAction private func goToSignIn(_ sender: UIButton) {
        router?.goToSignIn()
    }
    
    @IBAction private func goToSignUp(_ sender: UIButton) {
        router?.goToSignUp()
    }
}

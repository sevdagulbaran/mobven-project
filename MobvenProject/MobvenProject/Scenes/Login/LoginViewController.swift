//
//  LoginViewController.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 10.03.2023.
//

import UIKit
import CommonButton

protocol LoginDisplayLogic: AnyObject {
    func displayAuthorizedPerson(viewModel: Login.Fetch.ViewModel)
}

final class LoginViewController: UIViewController {
    
    var interactor: LoginBusinessLogic?
    var router: (LoginRoutingLogic & LoginDataPassing)?
    var viewModel: Login.Fetch.ViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.router?.goToHome()
            }
        }
    }

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var termsLabel: UILabel!
    @IBOutlet private weak var saveButton: CommonButton!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        setupTextField()
        configureBackButtonTitle("")
        hideKeyboardWhenTappedAround()
        
        
        let attributedText = NSMutableAttributedString(string: "By clicking continue you agree to our ")
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 10),
            .foregroundColor: UIColor.gradientColor
        ]
        
        let boldText = NSAttributedString(string: "Terms and Condition", attributes: boldAttributes)
        attributedText.append(boldText)
        attributedText.append(NSAttributedString(string: "."))
        
        termsLabel.attributedText = attributedText
        
    }
    
    private func setupTextField() {
        emailTextField.layer.cornerRadius = 17
        passwordTextField.layer.cornerRadius = 17
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    
    @IBAction private func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
                   let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Email or password is incorrect.")
                 return
             }
             interactor?.login(email: email, password: password)
         }
         
}
extension LoginViewController: LoginDisplayLogic {
    func displayAuthorizedPerson(viewModel: Login.Fetch.ViewModel) {
        self.viewModel = viewModel
    }
}

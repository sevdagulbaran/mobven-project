//
//  LoginViewController.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 10.03.2023.
//

import UIKit
protocol LoginDisplayLogic: AnyObject {
    
}

final class LoginViewController: UIViewController, LoginDisplayLogic {
    
    var interactor: LoginBusinessLogic?
    var router: (LoginRoutingLogic & LoginDataPassing)?
    
    
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var termsLabel: UILabel!
    @IBOutlet private weak var saveButton: UIButton!
    
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
        setupPhoneNumberTextField()
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
    
    private func setupPhoneNumberTextField() {
        phoneNumberTextField.delegate = self
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.layer.cornerRadius = 17
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    
    @IBAction private func saveNumberTapped(_ sender: UIButton) {
         router?.goToVerify()
//        if phoneNumberTextField.text?.count == 11 {
//
//        } else {
//            showAlert(message: "Please enter a valid 11 digit phone number.")
//        }
    }
}
// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        saveNumberTapped(saveButton)
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text?.count ?? 0) + string.count - range.length
        if newLength <= 11 && string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
            return true
        }
        else {
            showAlert(message: "Phone number cannot exceed 11 characters. Please enter a valid phone number.")
            return false
        }
    }
}


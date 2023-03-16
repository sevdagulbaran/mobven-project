//
//  RegisterViewController.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 7.03.2023.
//

import UIKit

protocol RegisterDisplayLogic: AnyObject {
    
}

final class RegisterViewController: UIViewController, RegisterDisplayLogic {
    
    // MARK: - Properties
    
    var interactor: RegisterBusinessLogic?
    var router: (RegisterRoutingLogic & RegisterDataPassing)?
    
    @IBOutlet private weak var mainTitleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    
    //MARK: - Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter()
        let router = RegisterRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        nameTextField.delegate = self
        nameTextField.layer.cornerRadius = 17
        hideKeyboardWhenTappedAround()
        configureBackButtonTitle("")
    }
    
    // MARK: - Actions
    
    @IBAction private func saveAccountInformationTapped(_ sender: UIButton) {
        router?.goToLogin()
    }
}

// MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        saveAccountInformationTapped(saveButton)
        return false
    }
}

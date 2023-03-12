//
//  LoginViewController.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 10.03.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var termsLabel: UILabel!
    @IBOutlet private weak var saveButton: UIButton!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButtonTitle("")
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        phoneNumberTextField.delegate = self
        phoneNumberTextField.layer.cornerRadius = 17
    }
    
    //MARK: - Actions
    
    @IBAction func saveNumberTapped(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: "VerifyViewController") as? VerifyViewController else {
            return
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        saveNumberTapped(saveButton)
        return false
    }
}

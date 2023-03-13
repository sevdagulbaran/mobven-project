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
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        phoneNumberTextField.delegate = self
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.layer.cornerRadius = 17
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
     
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    
    @IBAction private func saveNumberTapped(_ sender: UIButton) {
        
        if phoneNumberTextField.text?.count == 11 {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            
            guard let viewController = storyBoard.instantiateViewController(withIdentifier: "VerifyViewController") as? VerifyViewController else { return }
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            showAlert(message: "Please enter a valid 11 digit phone number.")
        }
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


//
//  VerifyViewController.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 12.03.2023.
//

import UIKit

final class VerifyViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet private weak var firstDigitField:  UITextField!
    @IBOutlet private weak var secondDigitField: UITextField!
    @IBOutlet private weak var thirdDigitField: UITextField!
    @IBOutlet private weak var fourthDigitField: UITextField!
    
    private var otpCode: String = ""
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        hideKeyboardWhenTappedAround()
        configureBackButtonTitle("")
        setupTextFields()
        setupKeyboardHiding()
    }
    
    private func setupTextFields() {
        
        for textField in [firstDigitField, secondDigitField, thirdDigitField, fourthDigitField] {
            textField?.delegate = self
            textField?.keyboardType = .numberPad
            textField?.textColor = .blueDark
            textField?.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        }
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
    }
    
    @objc private func textDidChange(_ textField: UITextField){
        
        guard let text = textField.text else { return }
        
        if text.count == 1 {
            switch textField {
            case firstDigitField:
                secondDigitField.becomeFirstResponder()
            case secondDigitField:
                thirdDigitField.becomeFirstResponder()
            case thirdDigitField:
                fourthDigitField.becomeFirstResponder()
            case fourthDigitField:
                fourthDigitField.resignFirstResponder()
            default:
                break
            }
        } else if  textField.text!.isEmpty {
            switch textField {
            case fourthDigitField:
                thirdDigitField.becomeFirstResponder()
            case thirdDigitField:
                secondDigitField.becomeFirstResponder()
            case secondDigitField:
                firstDigitField.becomeFirstResponder()
            case firstDigitField:
                firstDigitField.resignFirstResponder()
            default:
                break
            }
        }
    }
    
    private func verifyOTPCode() {
        
        let enteredCode = "\(firstDigitField.text ?? "")\(secondDigitField.text ?? "")\(thirdDigitField.text ?? "")\(fourthDigitField.text ?? "")"
        
        if enteredCode == otpCode {
            
        } else {
            
        }
    }

    private func clearTextField() {
        
        for textField in [firstDigitField, secondDigitField, thirdDigitField, fourthDigitField] {
            textField?.text = ""
        }
    }
    
    //MARK: - Actions
    
    @IBAction private func saveVerifyCodeTapped(_ sender: UIButton) {
        verifyOTPCode()
        clearTextField()
        
    }
}

//MARK: - UITextFieldDelegate

extension VerifyViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let currentText = textField.text else {
            return true
        }
        
        let newLength = currentText.count + string.count - range.length
        if newLength > 1 {
            return false
        }
        
        let allowedCharacterSet = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacterSet.isSuperset(of: characterSet)
    }
}

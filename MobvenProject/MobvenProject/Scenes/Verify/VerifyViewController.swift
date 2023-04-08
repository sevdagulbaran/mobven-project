//
//  VerifyViewController.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 12.03.2023.
//

import UIKit

protocol VerifyDisplayLogic: AnyObject {
    
}

final class VerifyViewController: UIViewController, VerifyDisplayLogic {
    
    //MARK: - Properties
    
    var interactor: VerifyBusinessLogic?
    var router: (VerifyRoutingLogic & VerifyDataPassing)?
    
    @IBOutlet private weak var firstDigitField:  UITextField!
    @IBOutlet private weak var secondDigitField: UITextField!
    @IBOutlet private weak var thirdDigitField: UITextField!
    @IBOutlet private weak var fourthDigitField: UITextField!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private var otpCode: String = ""
    
    //MARK: - LifeCycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    override func viewDidLoad() {
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
        let interactor = VerifyInteractor()
        let presenter = VerifyPresenter()
        let router = VerifyRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    //MARK: - Private Methods
    
    private func setupUI() {
        hideKeyboardWhenTappedAround()
        configureBackButtonTitle("")
        setupTextFields()
        setupKeyboardHiding()
    }
    
    private func setupTextFields() {
        let textFields = [firstDigitField, secondDigitField, thirdDigitField, fourthDigitField]
    
        for textField in textFields {
            textField?.delegate = self
            textField?.keyboardType = .numberPad
            textField?.textContentType = .oneTimeCode
            textField?.autocorrectionType = .no
            textField?.textColor = .blueDark
            textField?.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        }
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShowNotification),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHideNotification),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    //MARK: Code for scrolling
    
    @objc private func keyboardWillShowNotification(notification : Notification){
        if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let height = frame.cgRectValue.height
            scrollView.contentSize.height = scrollView.contentSize.height + height
        }
    }
    
    @objc private func keyboardWillHideNotification(notification : Notification){
        if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let height = frame.cgRectValue.height
            scrollView.contentSize.height = scrollView.contentSize.height - height
        }
    }
    
    @objc private func textDidChange(_ textField: UITextField) {
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
        router?.goToHome()
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

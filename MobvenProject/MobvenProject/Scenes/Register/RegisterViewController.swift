//
//  RegisterViewController.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 7.03.2023.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var mainTitleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        nameTextField.delegate = self
        nameTextField.layer.cornerRadius = 17
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Actions
    
    @IBAction private func saveAccountInformationTapped(_ sender: UIButton) {
        print("tapped")
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

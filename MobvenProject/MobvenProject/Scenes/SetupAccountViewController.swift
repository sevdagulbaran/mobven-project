//
//  SetupAccountViewController.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 7.03.2023.
//

import UIKit

final class SetupAccountViewController: UIViewController {
    
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
        hideKeyboard()
        setupUI()
    }
    
    // MARK: - Actions
    
    @IBAction func saveAccountInformationTapped(_ sender: UIButton) {
        print("tapped")
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        nameTextField.delegate = self
        nameTextField.layer.cornerRadius = 17
    }
    
    private func hideKeyboard() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension SetupAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        saveAccountInformationTapped(saveButton)
        return false
    }
}

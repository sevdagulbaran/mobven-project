//
//  ProfileViewController.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 9.04.2023.
//

import UIKit
import WebKit

protocol ProfileDisplayLogic: AnyObject {
    
}

final class ProfileViewController: UIViewController {
    
    // MARK: Property
    
    @IBOutlet private weak var modeSwitch: UISwitch!
    
    let birthDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    let genderPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let genderData = ["Male", "Female", "Other"]
    
    var interactor: ProfileBusinessLogic?
    var router: (ProfileRoutingLogic & ProfileDataPassing)?
    
    
    // MARK: Object lifecycle
    
    override func viewDidLoad() {
        storedMode()
        setupUI()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUI() {
        view.addSubview(birthDatePicker)
        NSLayoutConstraint.activate([
            birthDatePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            birthDatePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        genderPickerView.dataSource = self
        genderPickerView.delegate = self
        view.addSubview(genderPickerView)
        NSLayoutConstraint.activate([
            genderPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genderPickerView.topAnchor.constraint(equalTo: birthDatePicker.bottomAnchor, constant: 20),
            genderPickerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            genderPickerView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func storedMode() {
        guard let isMode = UserDefaults.standard.object(forKey: "isDarkMode") as? Bool else { return }
        modeSwitch.isOn = isMode
    }
    //MARK: - Actions
    
    @IBAction func openLinkedinButtonTapped(_ sender: Any) {
        let url = URL(string: "https://www.linkedin.com/in/sevdagulbaran")
        router?.goToWebView(url: url)
    }
    
    @IBAction private func changeModeTapped(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "isDarkMode")
        if let windowScene = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).first,
           let window = windowScene?.windows.first {
            window.overrideUserInterfaceStyle = sender.isOn ? .dark: .light
        }
    }
    
}
//MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension ProfileViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedGender = genderData[row]
        print("Selected gender: \(selectedGender)")
    }
}

extension ProfileViewController: ProfileDisplayLogic {
    
}

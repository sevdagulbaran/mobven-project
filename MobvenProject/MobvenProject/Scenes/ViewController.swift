//
//  ViewController.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 5.02.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let infoDict = Bundle.main.infoDictionary else { return }
        let backendURL = infoDict["BACKEND_URL"] as? String
        print(backendURL)
    }
}


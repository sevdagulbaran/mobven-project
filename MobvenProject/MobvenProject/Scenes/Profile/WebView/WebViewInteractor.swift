//
//  WebViewInteractor.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 10.04.2023.
//

import Foundation

protocol WebViewBusinessLogic: AnyObject {
    
}

protocol WebViewDataStore: AnyObject {
    
    
}

final class WebViewInteractor: WebViewBusinessLogic, WebViewDataStore {

    var presenter: WebViewPresentationLogic?
    var worker: WebViewWorkingLogic = WebViewWorker()
    
}

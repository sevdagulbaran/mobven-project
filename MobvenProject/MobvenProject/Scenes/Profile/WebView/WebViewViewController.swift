//
//  WebViewViewController.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 10.04.2023.
//

import UIKit
import WebKit

protocol WebViewDisplayLogic: AnyObject {
    
}

final class WebViewViewController: UIViewController {
    
    var interactor: WebViewBusinessLogic?
    var router: (WebViewRoutingLogic & WebViewDataPassing)?
    
    
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var forwardButton: UIButton!
    @IBOutlet private weak var refreshButton: UIButton!
    
    private let url = URL(string: "https://www.linkedin.com/in/sevdagulbaran")!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
        // setupWebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        loadURL()
        setupWebView()
    }
    // MARK: Setup
    
    private func setupWebView( ) {
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func setup() {
        let viewController = self
        let interactor = WebViewInteractor()
        let presenter = WebViewPresenter()
        let router = WebViewRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    private func loadURL(){
        // sadece linkedin domain icin kullanilabilir
        
//        guard let url = url else { return }
//        guard url.host == "www.linkedin.com" else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        webView.load(URLRequest(url: url))
    }
    
    
    // MARK: - IBActions
    
    @IBAction func backButtonTapped(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func forwardButtonTapped(_ sender: Any) {
        webView.goForward()
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        webView.reload()
    }
}

extension WebViewViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}


extension WebViewViewController: WebViewDisplayLogic {
    
}

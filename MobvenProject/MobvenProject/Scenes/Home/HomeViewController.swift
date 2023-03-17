//
//  HomeViewController.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 16.03.2023.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayUsers(userViewModels: [Groups.Fetch.ViewModel.User])
    func displayErrorMessage(_ errorMessage: String)
}

final class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?
    
    var usersViewModel: [Groups.Fetch.ViewModel.User]?
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchGroupsData()
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
    }
}

extension HomeViewController: HomeDisplayLogic {

    func displayUsers(userViewModels: [Groups.Fetch.ViewModel.User]) {
        usersViewModel = userViewModels
        DispatchQueue.main.async { 
            self.tableView.reloadData()
        }
    }
    
    func displayErrorMessage(_ errorMessage: String) {
        print("err")
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersViewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        
        guard let model = usersViewModel?[indexPath.row] else { return cell }
        cell.configureCell(viewModel: model)
        return cell
    }
}

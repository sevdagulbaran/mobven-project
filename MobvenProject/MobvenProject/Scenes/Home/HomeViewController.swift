//
//  HomeViewController.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 16.03.2023.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayGroups(groupViewModels: [Groups.Fetch.ViewModel.Group])
    func displayErrorMessage(_ errorMessage: String)
}

final class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet private weak var tableContainerView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    
    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?
    
    var groupsViewModels: [Groups.Fetch.ViewModel.Group]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.tableView.reloadData()
            }
        }
    }
    
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
    
    private func setupView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CustomHeaderView")
        collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.separatorStyle = .none
        tableContainerView.roundCorner([.topLeft,.topRight], radius: 45)
        
    }
}

//MARK: - HomeDisplayLogic

extension HomeViewController: HomeDisplayLogic {
    
    func displayGroups(groupViewModels: [Groups.Fetch.ViewModel.Group]) {
        groupsViewModels = groupViewModels
    
    }
    
    func displayErrorMessage(_ errorMessage: String) {
        //TODO: Added Alert
        print("session expired.")
    }
}

//MARK: - UICollectionView

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         groupsViewModels?.count ?? 0
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        guard let model = groupsViewModels?[indexPath.row] else { return cell }
        cell.setCell(group: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           CGSize(width: 210, height: 134)
       }
}

//MARK: - UITableView

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groupsViewModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        
        guard let model = groupsViewModels?[indexPath.row] else { return cell }
        cell.configureCell(viewModel: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}



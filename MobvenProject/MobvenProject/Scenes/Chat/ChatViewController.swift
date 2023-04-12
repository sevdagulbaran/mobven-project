//
//  ChatViewController.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 11.04.2023.
//

import UIKit
import PhotosUI

protocol ChatDisplayLogic: AnyObject {
    func displayUser(viewModel: Groups.Fetch.ViewModel.User)
}

final class ChatViewController: UIViewController {
    
    //  MARK: Properties
    @IBOutlet private var backButton: UIButton!
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var statusLabel: UILabel!
    @IBOutlet private var addMediaButton: UIButton!
    @IBOutlet private var chatCollectionView: UICollectionView!
    
    
    var interactor: ChatBusinessLogic?
    var router: (ChatRoutingLogic & ChatDataPassing)?
    
    var images: [UIImage]?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
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
        let interactor = ChatInteractor()
        let presenter = ChatPresenter()
        let router = ChatRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Handlers
    
    private func setupView() {
        navigationItem.hidesBackButton = true
        chatCollectionView.delegate = self
        chatCollectionView.dataSource = self
        chatCollectionView.register(
            UINib(nibName: "ChatCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "ChatCollectionViewCell"
        )
    }
    
    private func updateView(images: [UIImage]) {
        self.images = images
        
        chatCollectionView.collectionViewLayout = generateCompositionalLayout(imageCount: images.count)
        chatCollectionView.reloadData()
    }
    
    private func generateCompositionalLayout(imageCount: Int) -> UICollectionViewLayout {
        switch imageCount {
        case 1:
            return setupSingleCompositionalLayout()
        case 2:
            return setupTwoCompositionalLayout()
        case 3:
            return setupThreeCompositionalLayout()
        default:
            return setupFourCompositionalLayout()
        }
    }
    
    
    @IBAction private func backButtonTapped(_ sender: UIButton) {
        router?.backToHome()
    }
    
    @IBAction private func addMediaButtonTapped(_ sender: UIButton) {
        router?.showMedia()
        
    }
    
    @IBAction private func sendButtonTapped(_ sender: UIButton) {
    }
}

// MARK: - PHPickerViewControllerDelegate

extension ChatViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        var selectedImages: [UIImage] = []
        
        let group = DispatchGroup()
        
        for result in results {
            group.enter()
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                    if let image = object as? UIImage {
                        selectedImages.append(image)
                    }
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            self.updateView(images: selectedImages)
        }
    }
}


// MARK: - CollectionView Methods

extension ChatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        images?.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ChatCollectionViewCell",
            for: indexPath
        ) as? ChatCollectionViewCell else { return UICollectionViewCell() }
        guard let images else { return cell }
        
        cell.moreImagesView.isHidden = true
        
        if indexPath.item == 3, images.count > 4 {
            cell.moreImagesView.isHidden = false
        }
        cell.selectedImageView.image = images[indexPath.item]
        return cell
    }
}
extension ChatViewController {
    private func setupSingleCompositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 1, leading: 1, bottom: 1, trailing: 1)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1
        )
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setupTwoCompositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 1, leading: 1, bottom: 1, trailing: 1)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1 / 2),
            heightDimension: .fractionalHeight(1)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: 2
        )
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setupThreeCompositionalLayout() -> UICollectionViewLayout {
        let sizeForDouble = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let doubleItems = NSCollectionLayoutItem(layoutSize: sizeForDouble)
        doubleItems.contentInsets = .init(top: 1, leading: 1, bottom: 1, trailing: 1)
        let groupSizeForDouble = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1 / 2),
            heightDimension: .fractionalHeight(1 / 2)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSizeForDouble,
            repeatingSubitem: doubleItems,
            count: 2
        )
        
        let sizeForSingle = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1 / 2)
        )
        let singleItem = NSCollectionLayoutItem(layoutSize: sizeForSingle)
        singleItem.contentInsets = .init(top: 1, leading: 1, bottom: 1, trailing: 1)
        
        let mainGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            ),
            subitems: [group, singleItem]
        )
        
        let section = NSCollectionLayoutSection(group: mainGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setupFourCompositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 1, leading: 1, bottom: 1, trailing: 1)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1 / 2),
            heightDimension: .fractionalHeight(1 / 2)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: 2
        )
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension ChatViewController: ChatDisplayLogic {
    func displayUser(viewModel: Groups.Fetch.ViewModel.User) {
        nameLabel.text = viewModel.nameSurname
    }
}

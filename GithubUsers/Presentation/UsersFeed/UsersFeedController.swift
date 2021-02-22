//
//  UsersFeedController.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import UIKit

final class UsersFeedController: UIViewController {
    
    private enum Constants {
        static let cellHeight: CGFloat = 120
        static let searchBarPlaceholder = "User login"
        static let navigationTitle = "Users"
    }
    
    // MARK: - Views
    
    private let searchController = UISearchController()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    private var loaderViewController: LoaderViewController?
    
    // MARK: - Private properties
    
    private let viewModel: IUsersFeedViewModel
    private let router: IUsersFeedRouter
    private var disposal = Disposal()
    
    // MARK: - Initialization
    
    init(viewModel: IUsersFeedViewModel, router: IUsersFeedRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented for UsersFeedController")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearence()
        collectionConfigure()
        configureSearchController()
        bindViewModel()
        viewModel.load()
    }
    
    // MARK: - Private functions
    
    private func bindViewModel() {
        viewModel.state.observe { [weak self] state in
            guard let state = state else { return }
            switch state {
            case .loading:
                self?.showLoader()
            case .loaded:
                self?.collectionView.reloadData()
                self?.hideLoaderIfNeeded()
            case .loadedWithError(let error):
                print(error)
                self?.hideLoaderIfNeeded()
            }
        }.add(to: &disposal)
    }
    
    private func collectionConfigure() {
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
    
        collectionView.registerCell(UserFeedCell.self)
    }
    
    private func configureAppearence() {
        navigationItem.title = Constants.navigationTitle
        view.addFrameEqualitySubview(collectionView)
    }
    
    private func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.searchBarPlaceholder
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func showLoader() {
        let loaderController = LoaderViewController()
        loaderViewController = loaderController
        embed(loaderController, animated: false)
    }

    private func hideLoaderIfNeeded() {
        guard loaderViewController != nil else { return }
        loaderViewController?.unembed()
        loaderViewController = nil
    }
    
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource implementation

extension UsersFeedController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueConfigurableCell(UserFeedCell.self, for: indexPath),
            let cellViewModel = viewModel.viewModelForItemAt(indexPath)
        else { return .init() }
        cell.configure(with: cellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let userLogin = viewModel.viewModelForItemAt(indexPath)?.login else { return }
        router.routeToUserDetails(userLogin)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        .init(width: collectionView.bounds.width, height: Constants.cellHeight)
    }

}

// MARK: - SearchController delegate functions implementation

extension UsersFeedController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchBarIsEmpty = searchBar.text?.isEmpty ?? true
        viewModel.isFiltering = !searchBarIsEmpty && searchController.isActive
        viewModel.filterUsersForText(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.isFiltering = false
    }

}


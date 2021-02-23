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
        static let error = (title: "Error", actionTitle: "Try again")
    }
    
    // MARK: - Views
    
    private let searchController = UISearchController()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    private var loaderViewController: LoaderViewController?
    private var stubView: StubView?
    
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
            case .loaded(let itemsCount):
                guard let self = self else { return }
                defer {
                    self.hideLoaderIfNeeded()
                }
                guard  itemsCount > 0 else {
                    self.collectionView.reloadData()
                    self.performStubbing(withAction: !self.viewModel.isFiltering)
                    return
                }
                self.removeStubbingIfNeeded()
                self.collectionView.reloadData()
            case .loadedWithError(let error):
                self?.hideLoaderIfNeeded()
                self?.handleError(error)
                guard let itemsToShow = self?.viewModel.numberOfItems(), itemsToShow <= 0 else { return }
                self?.performStubbing(withAction: true)
            }
        }.add(to: &disposal)
    }
    
    private func handleError(_ error: Error) {
        let retryAction: () -> Void = { [weak self] in
            self?.viewModel.load()
        }
        router.routeToError(
            title: Constants.error.title,
            subtitle: error.localizedDescription,
            buttonTitle: Constants.error.actionTitle,
            mainAction: retryAction)
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
    
    private func performStubbing(withAction: Bool) {
        removeStubbingIfNeeded()
        let reloadAction: () -> Void = { [weak self] in self?.viewModel.load() }
        let action = withAction ? reloadAction : nil
        let stubView = StubView(completion: action)

        stubView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(stubView)
        NSLayoutConstraint.activate([
            stubView.centerXAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.centerXAnchor),
            stubView.centerYAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.centerYAnchor)
        ])
        self.stubView = stubView
    }
    
    private func removeStubbingIfNeeded() {
        guard let stubView = stubView else { return }
        stubView.removeFromSuperview()
        self.stubView = nil
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


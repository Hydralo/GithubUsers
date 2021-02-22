//
//  UsersFeedViewModel.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import Foundation

final class UsersFeedViewModel: IUsersFeedViewModel {
    
    typealias Completion = () -> Void
    
    private enum Constants {
        static let prefetchingLimit = 5
    }
    
    // MARK: - Properties
    
    let action: Observable<Action?> = Observable(nil)
    let state: Observable<State?> = Observable(nil)
    var isFiltering: Bool = false {
        didSet {
            guard !isFiltering else { return }
            filteredCellViewModels = cellViewModels
        }
    }
    
    // MARK: - Private properties

    private let service: IUsersFeedService
    private let imageService: IImageService
    private var cellViewModels: [IUserFeedCellViewModel] = []
    private var prefetchInProgress: Bool = false
    private var filteredCellViewModels: [IUserFeedCellViewModel] = [] {
        didSet {
            self.state.value = .loaded
        }
    }
    private var lastUserID: Int? {
        return cellViewModels.last?.id
    }
    
    // MARK: - Initialization
    
    init(service: IUsersFeedService, imageService: IImageService) {
        self.service = service
        self.imageService = imageService
    }
    
    // MARK: - Functions

    func load() {
        state.value = .loading
        requestUsersForCurrentPage()
    }
    
    func numberOfItems() -> Int {
        filteredCellViewModels.count
    }
    
    func viewModelForItemAt(_ indexPath: IndexPath) -> IUserFeedCellViewModel? {
        prefetchIfNeeded(indexPath)
        return filteredCellViewModels[safe: indexPath.item]
    }
    
    func filterUsersForText(_ searchText: String) {
        guard !searchText.isEmpty else {
            filteredCellViewModels = cellViewModels
            return
        }
        filteredCellViewModels = cellViewModels.filter {
            $0.login.contains(searchText.uppercased())
        }
    }
    
    // MARK: - Private functions
    
    private func requestUsersForCurrentPage(completion: Completion? = nil) {
        service.requestUsers(lastUserID: lastUserID) { [weak self] result in
            guard let self = self else { return }
            do {
                let users = try result.get()
                let cellModels = users.map {
                    UserFeedCellViewModel(
                        id: $0.id,
                        name: $0.login,
                        avatarURL: $0.avatarURL,
                        imageService: self.imageService
                    )
                }
                self.cellViewModels.append(contentsOf: cellModels)
                self.filteredCellViewModels = self.cellViewModels
                completion?()
            } catch {
                print(error)
                self.state.value = .loadedWithError(error)
            }
        }
    }
    
    private func prefetchIfNeeded(_ indexPath: IndexPath) {
        guard
            !prefetchInProgress,
            !isFiltering && ( filteredCellViewModels.count - indexPath.row ) < Constants.prefetchingLimit
        else { return }
        prefetchInProgress = true
        requestUsersForCurrentPage() { [weak self] in
            self?.prefetchInProgress = false
        }
    }

}

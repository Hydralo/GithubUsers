//
//  UsersFeedViewModel.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import Foundation

final class UsersFeedViewModel: IUsersFeedViewModel {
    
    // MARK: - Properties
    
    let state: Observable<State?> = Observable(nil)
    
    // MARK: - Private properties

    private let service: IUsersFeedService
    private let imageService: IImageService
    private var cellModels: [IUserFeedCellViewModel] = []
    private var pageCounter = 0
    
    // MARK: - Initialization
    
    init(service: IUsersFeedService, imageService: IImageService) {
        self.service = service
        self.imageService = imageService
    }
    
    // MARK: - Functions

    func load() {
        state.value = .loading
        service.requestUsers(pageIndex: pageCounter) { [weak self] result in
            guard let self = self else { return }
            do {
                let users = try result.get()
                users.forEach { print($0) }
                let cellModels = users.map {
                    UserFeedCellViewModel(
                        name: $0.name,
                        avatarURL: $0.avatarURL,
                        imageService: self.imageService
                    )
                }
                self.cellModels.append(contentsOf: cellModels)
                self.state.value = .loaded
            } catch {
                print(error)
                self.state.value = .loadedWithError(error)
            }
        }
    }
    
    func numberOfItems() -> Int {
        cellModels.count
    }
    
    func viewModelForItemAt(_ indexPath: IndexPath) -> IUserFeedCellViewModel? {
        cellModels[safe: indexPath.item]
    }
    
    func selectItemAt(_ indexPath: IndexPath) {
        print("Open details for user: \(cellModels[safe: indexPath.item]?.name)")
    }

}

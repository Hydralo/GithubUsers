//
//  IUsersFeedViewModel.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import Foundation

enum UsersFeedViewModelAction {
    case selectUser(id: Int)
    case update
}

enum UsersFeedViewModelState {
    case loading
    case loaded(count: Int)
    case loadedWithError(Error)
}

protocol IUsersFeedViewModel: AnyObject {
    typealias State = UsersFeedViewModelState
    typealias Action = UsersFeedViewModelAction
    
    var state: Observable<State?> { get }
    var action: Observable<Action?> { get }
    var isFiltering: Bool { get set }
    
    func load()
    func numberOfItems() -> Int
    func viewModelForItemAt(_ indexPath: IndexPath) -> IUserFeedCellViewModel?
    func filterUsersForText(_ searchText: String)
}

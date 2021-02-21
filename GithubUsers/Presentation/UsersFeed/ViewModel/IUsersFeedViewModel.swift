//
//  IUsersFeedViewModel.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import Foundation

enum UsersFeedViewModelState {
    case loading
    case loaded
    case loadedWithError(Error)
}

protocol IUsersFeedViewModel: AnyObject {
    typealias State = UsersFeedViewModelState
    
    var state: Observable<State?> { get }
    var isFiltering: Bool { get set }
    
    func load()
    func numberOfItems() -> Int
    func viewModelForItemAt(_ indexPath: IndexPath) -> IUserFeedCellViewModel?
    func selectItemAt(_ indexPath: IndexPath)
    func filterUsersForText(_ searchText: String)
}

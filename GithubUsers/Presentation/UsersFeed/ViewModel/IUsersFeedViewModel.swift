//
//  IUsersFeedViewModel.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import Foundation

protocol IUsersFeedViewModel: AnyObject {
    func load()
    func viewModelForItemAt(_ indexPath: IndexPath)
    func selectItemAt(_ indexPath: IndexPath)
}

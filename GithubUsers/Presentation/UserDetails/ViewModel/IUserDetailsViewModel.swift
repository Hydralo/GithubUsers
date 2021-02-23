//
//  IUserDetailsViewModel.swift
//  GithubUsers
//
//  Created by Igor on 22.02.2021.
//

import UIKit

enum UserDetailsViewModelState {
    case loading
    case loaded
    case loadedWithError(Error)
}

protocol IUserDetailsViewModel: AnyObject {
    typealias State = UserDetailsViewModelState
    typealias UserTextInfo = (name: String, bio: String?)
    typealias UserQuantitativeInfo = (publicRepoCount: Int, followers: Int, following: Int)
    
    var state: Observable<State?> { get }
    var userName: String { get }
    var userInfo: Observable<(textInfo: UserTextInfo, quantitativeInfo: UserQuantitativeInfo)?> { get }
    var avatarImage: Observable<UIImage?> { get }
    
    func load()
}

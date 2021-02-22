//
//  IUserDetailsViewModel.swift
//  GithubUsers
//
//  Created by Igor on 22.02.2021.
//

import UIKit

protocol IUserDetailsViewModel: AnyObject {
    typealias UserTextInfo = (name: String, bio: String?)
    typealias UserQuantitativeInfo = (publicRepoCount: Int, followers: Int, following: Int)
    
    var userName: String { get }
    var userInfo: Observable<(textInfo: UserTextInfo, quantitativeInfo: UserQuantitativeInfo)?> { get }
    var avatarImage: Observable<UIImage?> { get }
    
    func load()
}

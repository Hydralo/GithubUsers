//
//  IUserFeedCellViewModel.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import UIKit

protocol IUserFeedCellViewModel: AnyObject {
    var avatarImage: Observable<UIImage?> { get }
    var name: String { get }
}

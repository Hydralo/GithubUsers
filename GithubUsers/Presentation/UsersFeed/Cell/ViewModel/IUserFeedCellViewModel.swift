//
//  IUserFeedCellViewModel.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import UIKit

protocol IUserFeedCellViewModel: AnyObject {
    var id: Int { get }
    var avatarImage: Observable<UIImage?> { get }
    var login: String { get }
    
    func prepareForReuse()
}

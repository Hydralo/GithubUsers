//
//  UserFeedCellViewModel.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import UIKit

final class UserFeedCellViewModel: IUserFeedCellViewModel {

    // MARK: - Properties
    
    let avatarImage: Observable<UIImage?> = Observable(nil)
    let name: String
    
    // MARK: - Initialization
    
    init(name: String, avatarURL: URL) {
        self.name = name.uppercased()
    }
    
    // MARK: - Private functions
    
    private func loadAvatarImage(_ url: URL) {
        // TODO: Implement service
    }
    
}

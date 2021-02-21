//
//  UsersFeedRouter.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import UIKit

final class UsersFeedRouter: IUsersFeedRouter {
    
    // MARK: - Functions

    func getConfiguredRootViewController() -> UIViewController {
        UsersFeedController()
    }

}

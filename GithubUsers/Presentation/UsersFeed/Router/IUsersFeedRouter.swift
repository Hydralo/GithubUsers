//
//  IUsersFeedRouter.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import UIKit

protocol IUsersFeedRouter: AnyObject {
    func getConfiguredRootViewController() -> UIViewController
    func routeToUserDetails(_ userID: Int)
}

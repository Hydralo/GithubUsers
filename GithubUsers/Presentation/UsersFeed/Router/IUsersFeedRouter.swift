//
//  IUsersFeedRouter.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import UIKit

protocol IUsersFeedRouter: AnyObject {
    typealias Completion = () -> Void
    
    func getConfiguredRootViewController() -> UIViewController
    func routeToUserDetails(_ userName: String)
    func routeToError(
        title: String,
        subtitle: String,
        buttonTitle: String,
        mainAction: @escaping Completion,
        closeAction: Completion?
    )
}

extension IUsersFeedRouter {
    func routeToError(title: String, subtitle: String, buttonTitle: String, mainAction: @escaping Completion) {
        routeToError(title: title, subtitle: subtitle, buttonTitle: buttonTitle, mainAction: mainAction, closeAction: nil)
    }
}

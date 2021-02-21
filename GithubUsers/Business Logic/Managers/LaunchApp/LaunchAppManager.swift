//
//  LaunchAppManager.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import UIKit

final class LaunchAppManager: ILaunchAppManager {
    
    // MARK: - Private properties
    
    private let rootRouter: IUsersFeedRouter = UsersFeedRouter()
    
    // MARK: - Functions
    
    func generateWindow() -> UIWindow {
        let window = UIWindow()
        window.rootViewController = rootRouter.getConfiguredRootViewController()
        window.makeKeyAndVisible()
        return window
    }
}

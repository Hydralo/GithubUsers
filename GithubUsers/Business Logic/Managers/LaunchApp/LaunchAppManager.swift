//
//  LaunchAppManager.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import UIKit

final class LaunchAppManager: ILaunchAppManager {
    
    // MARK: - Functions
    
    func generateWindow() -> UIWindow {
        let window = UIWindow()
        let rootRouter = UsersFeedRouter()
        window.rootViewController = rootRouter.getConfiguredRootViewController()
        window.makeKeyAndVisible()
        return window
    }
}

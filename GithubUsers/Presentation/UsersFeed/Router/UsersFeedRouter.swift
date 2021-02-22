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
        let networkClient = NetworkClient()
        let service = UserFeedService(networkClient: networkClient, configurator: UserFeedServiceConfigurator())
        let imageService = ImageService(networkClient: networkClient, configurator: ImageServiceConfigurator())
        let viewModel = UsersFeedViewModel(service: service, imageService: imageService)
        let feedController = UsersFeedController(viewModel: viewModel, router: self)
        return UINavigationController(rootViewController: feedController)
    }
    
    func routeToUserDetails(_ userID: Int) {
        print("Route to user with ID: \(userID)")
    }
    
}

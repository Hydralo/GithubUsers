//
//  UsersFeedRouter.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import UIKit

final class UsersFeedRouter: IUsersFeedRouter {

    private var navigationController: UINavigationController?
    private lazy var networkClient: INetworkClient = NetworkClient()
    private lazy var imageService: IImageService = ImageService(
        networkClient: networkClient,
        configurator: ImageServiceConfigurator()
    )
    
    // MARK: - Functions

    func getConfiguredRootViewController() -> UIViewController {
        let service = UserFeedService(networkClient: networkClient, configurator: UserFeedServiceConfigurator())
        let viewModel = UsersFeedViewModel(service: service, imageService: imageService)
        let feedController = UsersFeedController(viewModel: viewModel, router: self)
        let navigationController = UINavigationController(rootViewController: feedController)
        self.navigationController = navigationController
        return navigationController
    }
    
    func routeToUserDetails(_ userName: String) {
        let service = UserDetailsService(networkClient: networkClient, configurator: UserDetailsServiceConfigurator())
        let viewModel = UserDetailsViewModel(userName: userName, service: service, imageService: imageService)
        let detailsController = UserDetailsController(viewModel: viewModel, router: self)
        navigationController?.pushViewController(detailsController, animated: true)
    }
    
    func routeToError(
        title: String,
        subtitle: String,
        buttonTitle: String,
        mainAction: @escaping Completion,
        closeAction: Completion?
    ) {
        let errorController = ErrorController(
            title: title,
            subtitle: subtitle,
            buttonTitle: buttonTitle,
            mainAction: mainAction,
            closeAction: closeAction
        )
        errorController.modalPresentationStyle = .fullScreen
        errorController.modalTransitionStyle = .crossDissolve
        navigationController?.topViewController?.present(errorController, animated: true)
    }
    
    func routeToRoot() {
        navigationController?.popToRootViewController(animated: false)
    }
    
}

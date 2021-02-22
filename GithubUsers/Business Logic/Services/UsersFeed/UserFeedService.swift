//
//  UserFeedService.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

final class UserFeedService: IUsersFeedService {

    // MARK: - Private properties
    
    let networkClient: INetworkClient
    let configurator: IUserFeedServiceConfigurator
    
    // MARK: - Initialization
    
    init(networkClient: INetworkClient, configurator: IUserFeedServiceConfigurator) {
        self.networkClient = networkClient
        self.configurator = configurator
    }
    
    // MARK: - Functions

    func requestUsers(lastUserID: Int?, completion: @escaping Completion) {
        let requestConfiguration = configurator.userFeedRequestConfiguration(lastUserID: lastUserID)
        networkClient.request(with: requestConfiguration, completionQueue: .main, completion: completion)
    }
    
}

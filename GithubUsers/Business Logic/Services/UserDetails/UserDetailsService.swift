//
//  UserDetailsService.swift
//  GithubUsers
//
//  Created by Igor on 22.02.2021.
//

final class UserDetailsService: IUserDetailsService {
    
    // MARK: - Private properties
    
    let networkClient: INetworkClient
    let configurator: IUserDetailsServiceConfigurator
    
    // MARK: - Initialization
    
    init(networkClient: INetworkClient, configurator: IUserDetailsServiceConfigurator) {
        self.networkClient = networkClient
        self.configurator = configurator
    }
    
    // MARK: - Functions

    func requestUserDetails(userName: String, completion: @escaping Completion) {
        let requestConfiguration = configurator.userDetailsRequestConfiguration(userName: userName)
        networkClient.request(with: requestConfiguration, completionQueue: .main, completion: completion)
    }

}

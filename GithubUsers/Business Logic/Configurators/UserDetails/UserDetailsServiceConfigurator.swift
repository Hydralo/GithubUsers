//
//  UserDetailsServiceConfigurator.swift
//  GithubUsers
//
//  Created by Igor on 22.02.2021.
//

final class UserDetailsServiceConfigurator: IUserDetailsServiceConfigurator {
    func userDetailsRequestConfiguration(userName: String) -> IRequestConfiguration {
        RequestConfiguration(
            baseURL: API.usersFeed.baseURL,
            path: API.Path.userDetails.rawValue + userName,
            method: .get,
            bodyParameters: nil,
            urlParameters: nil,
            headers: [API.Header.Key.accept.rawValue: API.Header.Value.applicationVNDjson.rawValue]
        )
    }
}

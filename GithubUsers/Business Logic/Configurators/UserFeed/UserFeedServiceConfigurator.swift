//
//  UserFeedServiceConfigurator.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

final class UserFeedServiceConfigurator: IUserFeedServiceConfigurator {

    func userFeedRequestConfiguration(pageIndex: Int) -> IRequestConfiguration {
        RequestConfiguration(
            baseURL: API.usersFeed.baseURL,
            path: API.Path.users.rawValue,
            method: .get,
            bodyParameters: nil,
            urlParameters: nil,
            headers: [API.Header.Key.accept.rawValue: API.Header.Value.applicationVNDjson.rawValue]
        )
    }

}

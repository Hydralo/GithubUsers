//
//  UserFeedServiceConfigurator.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

final class UserFeedServiceConfigurator: IUserFeedServiceConfigurator {

    func userFeedRequestConfiguration(lastUserID: Int?) -> IRequestConfiguration {
        var parameters: Parameters?
        if let lastUserID = lastUserID { parameters = [API.Header.Key.lastUserID.rawValue: lastUserID] }
        return RequestConfiguration(
            baseURL: API.usersFeed.baseURL,
            path: API.Path.users.rawValue,
            method: .get,
            bodyParameters: nil,
            urlParameters: parameters,
            headers: [API.Header.Key.accept.rawValue: API.Header.Value.applicationVNDjson.rawValue]
        )
    }

}

//
//  IUserFeedServiceConfigurator.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

protocol IUserFeedServiceConfigurator: AnyObject {
    func userFeedRequestConfiguration(lastUserID: Int?) -> IRequestConfiguration
}

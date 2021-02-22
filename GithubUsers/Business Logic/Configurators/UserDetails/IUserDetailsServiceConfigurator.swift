//
//  IUserDetailsConfigurator.swift
//  GithubUsers
//
//  Created by Igor on 22.02.2021.
//

protocol IUserDetailsServiceConfigurator: AnyObject {
    func userDetailsRequestConfiguration(userName: String) -> IRequestConfiguration
}

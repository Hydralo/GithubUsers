//
//  DetailedUser.swift
//  GithubUsers
//
//  Created by Igor on 22.02.2021.
//

import Foundation

struct DetailedUser: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case login = "login"
        case avatarURL = "avatar_url"
        case name
        case bio
        case publicRepoCount = "public_repos"
        case followers
        case following
    }
    
    let id: Int
    let login: String
    let avatarURL: URL
    let name: String
    let bio: String?
    let publicRepoCount: Int
    let followers: Int
    let following: Int
}

//
//  BriefUser.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import Foundation

struct BriefUser: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case login = "login"
        case avatarURL = "avatar_url"
    }
    
    let id: Int
    let login: String
    let avatarURL: URL
}

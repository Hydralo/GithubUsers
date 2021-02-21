//
//  BriefUser.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import Foundation

struct BriefUser: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatarURL = "avatar_url"
    }
    
    let name: String
    let avatarURL: URL
}

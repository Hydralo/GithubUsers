//
//  API.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import Foundation

enum API {
    
    case usersFeed
    
    var baseURLComponents: URLComponents {
        switch self {
        case .usersFeed:
            return URLComponents(string: "https://api.github.com")!
        }
    }
    
    var baseURL: URL {
        return baseURLComponents.url!
    }
    
    enum Header {
        enum Key: String {
            case accept = "Accept"
            case lastUserID = "since"
        }

        enum Value: String {
            case applicationVNDjson = "application/vnd.github.v3+json"
        }
    }
    
    enum Path: String {
        case users = "users"
    }
    
}

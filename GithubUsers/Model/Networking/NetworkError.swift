//
//  NetworkError.swift
//  GithubUsers
//
//  Created by Igor on 22.02.2021.
//

import Foundation

enum NetworkError: String, LocalizedError {
    case missingURL
    case parametersNil
    case encodingFailed
    case unknown
    
    // MARK: - Properies

    var errorDescription: String? {
        switch self {
        case .missingURL:
            return "NetworkError. URL missing while network request"
        case .parametersNil:
            return "NetworkError. Parameters missing while network request"
        case .encodingFailed:
            return "NetworkError. Failed to encode request parameters"
        case .unknown:
            return "NetworkError. Something went wrong"
        }
    }
}

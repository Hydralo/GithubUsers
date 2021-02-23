//
//  NetworkResponseError.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import Foundation

enum NetworkResponseError: Error, LocalizedError {
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableTodecode
    
    // MARK: - Properies

    var errorDescription: String? {
        switch self {
        case .authenticationError:
            return "NetworkResponseError. Authentication error"
        case .badRequest:
            return "NetworkResponseError. API returned \"ad request\""
        case .outdated:
            return "NetworkResponseError. Request outdated"
        case .failed:
            return "NetworkResponseError. Failed network response handling"
        case .noData:
            return "NetworkResponseError. API returned no data"
        case .unableTodecode:
            return "NetworkResponseError. Failed to decode API response"
        }
    }
}

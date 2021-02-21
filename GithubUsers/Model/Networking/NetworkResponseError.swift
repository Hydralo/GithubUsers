//
//  NetworkResponseError.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

public enum NetworkError: String, Error {
    case missingURL
    case parametersNil
    case encodingFailed
    case unknown
}

public enum NetworkResponseError: Error {
    case success
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableTodecode
}

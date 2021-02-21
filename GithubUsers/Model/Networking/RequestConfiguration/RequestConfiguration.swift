//
//  RequestConfiguration.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import Foundation

final class RequestConfiguration: IRequestConfiguration {
  
    // MARK: - Constants

    private enum Constants {
        static let timeout: Double = 10
    }

    // MARK: - Properties

    let baseURL: URL
    let path: String
    let method: HTTPMethod
    let bodyParameters: Parameters?
    let urlParameters: Parameters?
    let headers: HTTPHeaders?
    let timeout: TimeInterval

    var endpoint: URL {
        path.isEmpty ? baseURL : baseURL.appendingPathComponent(path, isDirectory: false)
    }

    // MARK: - Initialization

    public init(baseURL: URL,
                path: String,
                method: HTTPMethod,
                bodyParameters: Parameters?,
                urlParameters: Parameters?,
                headers: HTTPHeaders?,
                timeout: Double = Constants.timeout) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.bodyParameters = bodyParameters
        self.urlParameters = urlParameters
        self.headers = headers
        self.timeout = timeout
    }
    
}

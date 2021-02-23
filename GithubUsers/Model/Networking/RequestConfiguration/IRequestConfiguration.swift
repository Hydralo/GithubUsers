//
//  IRequestConfiguration.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import Foundation

typealias HTTPHeaders = [String: String]
typealias Parameters = [String: Any]

protocol IRequestConfiguration {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var bodyParameters: Parameters? { get }
    var urlParameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
    var endpoint: URL { get }
    var timeout: Double { get }
}


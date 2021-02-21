//
//  URLParametersEncoder.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import Foundation

struct URLParametersEncoder: IParametersEncoder {

    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }

        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            let queryItems: [URLQueryItem] = parameters.map {
                URLQueryItem(name: $0, value: "\($1)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
            }
            urlComponents.queryItems = queryItems
            urlRequest.url = urlComponents.url
        }
    }

}

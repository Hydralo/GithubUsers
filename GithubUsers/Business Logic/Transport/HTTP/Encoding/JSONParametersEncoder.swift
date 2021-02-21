//
//  JSONParametersEncoder.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import Foundation

struct JSONParametersEncoder: IParametersEncoder {

    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
        } catch {
            throw NetworkError.encodingFailed
        }
    }

}

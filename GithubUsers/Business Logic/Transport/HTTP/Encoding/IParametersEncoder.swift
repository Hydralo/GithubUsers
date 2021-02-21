//
//  IParametersEncoder.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import Foundation

protocol IParametersEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

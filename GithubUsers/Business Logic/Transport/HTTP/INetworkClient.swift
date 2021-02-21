//
//  INetworkClient.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import Foundation

protocol INetworkClient: class {
    typealias TypedCompletion<T> = (Result<T, Error>) -> Void
    typealias Completion = (Result<Data, Error>) -> Void

    func request<T: Decodable>(
        with configuration: IRequestConfiguration,
        completionQueue: DispatchQueue,
        completion: @escaping TypedCompletion<T>
    )
    func request(
        with configuration: IRequestConfiguration,
        completionQueue: DispatchQueue,
        completion: @escaping Completion
    )
    func cancelAllRequests()
    func cancelRequestWithURL(from configuration: IRequestConfiguration)
}

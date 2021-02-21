//
//  NetworkClient.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import Foundation

final class NetworkClient: INetworkClient {

    // MARK: - Private properties

    private let session: URLSession
    private let jsonParametersEncoder: IParametersEncoder
    private let urlParametersEncoder: IParametersEncoder

    // MARK: - Initialization

    init(
        session: URLSession = URLSession(configuration: .default),
        jsonParametersEncoder: IParametersEncoder = JSONParametersEncoder(),
        urlParametersEncoder: IParametersEncoder = URLParametersEncoder()
    ) {
        self.session = session
        self.jsonParametersEncoder = jsonParametersEncoder
        self.urlParametersEncoder = urlParametersEncoder
    }

    // MARK: - Public functions

    func request(
        with configuration: IRequestConfiguration,
        completionQueue: DispatchQueue,
        completion: @escaping Completion
    ) {
        do {
            let request = try self.createRequest(with: configuration)
            session.dataTask(with: request) { [weak self] (data, response, error) in
                if let error = error { completion(.failure(error)) }
                guard let self = self else { return }
                let result = self.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    guard let responseData = data else { return completion(.failure(NetworkResponseError.noData)) }
                    DispatchQueue.main.async { completion(.success(responseData)) }
                case .failure(let error):
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
            }.resume()
        } catch {
            DispatchQueue.main.async { completion(.failure(error)) }
        }
    }

    func request<T: Decodable>(
        with configuration: IRequestConfiguration,
        completionQueue: DispatchQueue,
        completion: @escaping TypedCompletion<T>
    ) {
        request(with: configuration, completionQueue: completionQueue) { result in
            switch result {
            case .success(let responseData):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: responseData)
                    completionQueue.async { completion(.success(decodedData)) }
                } catch {
                    completionQueue.async { completion(.failure(NetworkResponseError.unableTodecode)) }
                }
            case .failure(let error):
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }

    func cancelAllRequests() {
       session.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }
    }

    func cancelRequestWithURL(from configuration: IRequestConfiguration) {
        session.getAllTasks { tasks in
            tasks.forEach {
                    if $0.originalRequest?.url == configuration.endpoint { $0.cancel() }
            }
        }
    }

    // MARK: - Private functions

    private func createRequest(with configuration: IRequestConfiguration) throws -> URLRequest {
        var request = URLRequest(url: configuration.endpoint, timeoutInterval: configuration.timeout)
        request.httpMethod = configuration.method.rawValue.uppercased()
        request.allHTTPHeaderFields = configuration.headers

        if let bodyParameters = configuration.bodyParameters {
            try jsonParametersEncoder.encode(urlRequest: &request, with: bodyParameters)
        }
        if let urlParameters = configuration.urlParameters {
            try urlParametersEncoder.encode(urlRequest: &request, with: urlParameters)
        }
        return request
    }

    private func handleNetworkResponse(_ response: URLResponse?) -> Result<Void, Error> {
        guard let response = response as? HTTPURLResponse else { return .failure(NetworkResponseError.failed) }
        switch response.statusCode {
        case 200...299: return .success(())
        case 401...500: return .failure(NetworkResponseError.authenticationError)
        case 501...599: return .failure(NetworkResponseError.badRequest)
        case 600: return .failure(NetworkResponseError.outdated)
        default: return .failure(NetworkResponseError.failed)
        }
    }

}


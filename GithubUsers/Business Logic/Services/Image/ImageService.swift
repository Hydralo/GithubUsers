//
//  ImageService.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import UIKit

final class ImageService: IImageService {

    // MARK: - Private properties

    private let networkClient: INetworkClient
    private let configurator: IImageServiceConfigurator
    private var imageCache: [URL: UIImage] = [:]

    // MARK: - Initializator

    init(networkClient: INetworkClient, configurator: IImageServiceConfigurator) {
        self.networkClient = networkClient
        self.configurator = configurator
    }

    // MARK: - Functions

    func requestImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.first(where: { $0.key == url })?.value {
            return completion(cachedImage)
        }
        let configuration = configurator.imageRequestConfiguration(url: url)
        networkClient.request(with: configuration, completionQueue: .main) { [weak self] result in
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                self?.imageCache[url] = image
                completion(image)
            case .failure(let error):
                completion(nil)
                print(error.localizedDescription)
            }
        }
    }
    
    func cancelRequest(url: URL) {
        let configuration = configurator.imageRequestConfiguration(url: url)
        networkClient.cancelRequestWithURL(from: configuration)
    }

}

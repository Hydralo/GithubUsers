//
//  ImageServiceConfigurator.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import Foundation

final class ImageServiceConfigurator: IImageServiceConfigurator {

    // MARK: - Functions

    func imageRequestConfiguration(url: URL) -> IRequestConfiguration {
        RequestConfiguration(
            baseURL: url,
            path: "",
            method: .get,
            bodyParameters: nil,
            urlParameters: nil,
            headers: nil
        )
    }

}

//
//  IImageServiceConfigurator.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import Foundation

protocol IImageServiceConfigurator: AnyObject {
    func imageRequestConfiguration(url: URL) -> IRequestConfiguration
}


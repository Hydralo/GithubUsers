//
//  IImageService.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import UIKit

protocol IImageService: AnyObject {
    func requestImage(with url: URL, completion: @escaping (UIImage?) -> Void)
    func cancelRequest(url: URL)
}

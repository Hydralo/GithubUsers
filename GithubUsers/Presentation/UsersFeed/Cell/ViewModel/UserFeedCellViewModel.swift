//
//  UserFeedCellViewModel.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import UIKit

final class UserFeedCellViewModel: IUserFeedCellViewModel {

    // MARK: - Properties
    
    let avatarImage: Observable<UIImage?> = Observable(nil)
    let name: String
    
    // MARK: - Private properties
    
    private let imageService: IImageService
    private let imageURL: URL
    private var disposal = Disposal()
    
    // MARK: - Initialization
    
    init(name: String, avatarURL: URL, imageService: IImageService) {
        self.name = name.uppercased()
        self.imageService = imageService
        self.imageURL = avatarURL
        loadAvatarImage()
    }
    
    // MARK: - Functions
    
    func prepareForReuse() {
        imageService.cancelRequest(url: imageURL)
    }
    
    // MARK: - Private functions
    
    private func loadAvatarImage() {
        imageService.requestImage(with: imageURL) { [weak self] image in
            self?.avatarImage.value = image
        }
    }
    
}

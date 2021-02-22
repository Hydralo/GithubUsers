//
//  UserFeedCellViewModel.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import UIKit

final class UserFeedCellViewModel: IUserFeedCellViewModel {

    // MARK: - Properties
    
    let id: Int
    let login: String
    let avatarImage: Observable<UIImage?> = Observable(nil)
    
    
    // MARK: - Private properties
    
    private let imageService: IImageService
    private let imageURL: URL
    private var disposal = Disposal()
    
    // MARK: - Initialization
    
    init(id: Int, name: String, avatarURL: URL, imageService: IImageService) {
        self.id = id
        self.login = name.uppercased()
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

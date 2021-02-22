//
//  UserDetailsViewModel.swift
//  GithubUsers
//
//  Created by Igor on 22.02.2021.
//

import UIKit

final class UserDetailsViewModel: IUserDetailsViewModel {
    
    // MARK: - Properties
    
    let userName: String
    let userInfo: Observable<(textInfo: UserTextInfo, quantitativeInfo: UserQuantitativeInfo)?> = Observable(nil)
    let avatarImage: Observable<UIImage?> = Observable(nil)
    
    // MARK: - Private properties
    
    private let service: IUserDetailsService
    private let imageService: IImageService
    
    // MARK: - Initialization
    
    init(userName: String, service: IUserDetailsService, imageService: IImageService) {
        self.userName = userName
        self.service = service
        self.imageService = imageService
    }
    
    // MARK: - Functions
    
    func load() {
        service.requestUserDetails(userName: userName) { [weak self] result in
            do {
                let detailedUser = try result.get()
                let userTextInfo: UserTextInfo = (name: detailedUser.name, bio: detailedUser.bio)
                let userQuantitativeInfo: UserQuantitativeInfo = (
                    publicRepoCount: detailedUser.publicRepoCount,
                    followers: detailedUser.followers,
                    following: detailedUser.following
                )
                self?.userInfo.value = (textInfo: userTextInfo, quantitativeInfo: userQuantitativeInfo)
                self?.loadAvatarImage(imageURL: detailedUser.avatarURL)
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - Private functions
    
    private func loadAvatarImage(imageURL: URL) {
        imageService.requestImage(with: imageURL) { [weak self] image in
            self?.avatarImage.value = image
        }
    }
    
}

//
//  UsersFeedViewModel.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import Foundation

final class UsersFeedViewModel: IUsersFeedViewModel {

    private let service: IUsersFeedService
    private var pageCounter = 0
    
    init(service: IUsersFeedService) {
        self.service = service
    }

    func load() {
        service.requestUsers(pageIndex: pageCounter) {
            do {
                let users = try $0.get()
                users.forEach { print($0) }
            } catch {
                print(error)
            }
        }
    }
    
    func viewModelForItemAt(_ indexPath: IndexPath) {
        
    }
    
    func selectItemAt(_ indexPath: IndexPath) {
        
    }

}

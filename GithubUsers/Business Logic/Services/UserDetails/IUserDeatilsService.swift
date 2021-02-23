//
//  IUserDeatilsService.swift
//  GithubUsers
//
//  Created by Igor on 22.02.2021.
//

protocol IUserDetailsService: AnyObject {
    typealias Completion = (Result<DetailedUser, Error>) -> Void
    
    func requestUserDetails(userName: String, completion: @escaping Completion)
}

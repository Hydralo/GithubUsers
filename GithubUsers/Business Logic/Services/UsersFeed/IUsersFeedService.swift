//
//  IUsersFeedService.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

protocol IUsersFeedService: AnyObject {
    typealias Completion = (Result<[BriefUser], Error>) -> Void
    
    func requestUsers(lastUserID: Int?, completion: @escaping Completion)
}

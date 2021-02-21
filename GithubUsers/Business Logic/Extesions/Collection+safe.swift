//
//  Collection+safe.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

public extension Collection {

    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

}

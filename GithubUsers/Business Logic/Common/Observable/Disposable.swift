//
//  Disposable.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

typealias Disposal = [Disposable]

final class Disposable {

    // MARK: - Private properties

    private let dispose: () -> Void

    // MARK: - Initialization

    init(_ dispose: @escaping () -> Void) {
        self.dispose = dispose
    }

    // MARK: - Lifecycle

    deinit {
        dispose()
    }

    // MARK: - Functions

    func add(to disposal: inout Disposal) {
        disposal.append(self)
    }

}

//
//  Disposable.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

public typealias Disposal = [Disposable]

public final class Disposable {

    // MARK: - Private properties

    private let dispose: () -> Void

    // MARK: - Initialization

    public init(_ dispose: @escaping () -> Void) {
        self.dispose = dispose
    }

    // MARK: - Lifecycle

    deinit {
        dispose()
    }

    // MARK: - Public functions

    public func add(to disposal: inout Disposal) {
        disposal.append(self)
    }

}

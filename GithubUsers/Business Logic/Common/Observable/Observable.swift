//
//  Observable.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

final class Observable<T> {

    typealias Observer = (T) -> Void

    // MARK: - properties

    var value: T {
        didSet {
            observers.values.forEach { $0(value) }
        }
    }

    // MARK: - Private properties

    private var observers: [Int: Observer] = [:]
    private var uniqueID = (0...).makeIterator()

    // MARK: - Initialization

    init(_ value: T) {
        self.value = value
    }

    // MARK: - functions

    /**
     Subsribe to value changing.

     - Returns: Block that removes created observer. Should be placed into Disposal.
     Disposal should be flushed after observer deinit.
     */
    func observe(_ observer: @escaping Observer) -> Disposable {
        guard let id = uniqueID.next() else { fatalError("There should always be a next unique id") }

        observers[id] = observer
        observer(value)

        let disposable = Disposable { [weak self] in
            self?.observers[id] = nil
        }

        return disposable
    }

    /// Remove all observers for Observable entity.
    func removeAllObservers() {
        observers.removeAll()
    }

}

// MARK: - Observable extension

extension Observable where T: Equatable {

    static func == (lhs: Observable, rhs: Observable) -> Bool {
        return lhs.value == rhs.value
    }

    func updateIfNeeded(with value: T) {
        guard self.value != value else { return }
        self.value = value
    }

}

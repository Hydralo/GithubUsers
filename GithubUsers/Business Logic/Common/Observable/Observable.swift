//
//  Observable.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

public final class Observable<T> {

    public typealias Observer = (T) -> Void

    // MARK: - Public properties

    public var value: T {
        didSet {
            observers.values.forEach { $0(value) }
        }
    }

    // MARK: - Private properties

    private var observers: [Int: Observer] = [:]
    private var uniqueID = (0...).makeIterator()

    // MARK: - Initialization

    public init(_ value: T) {
        self.value = value
    }

    // MARK: - Public functions

    /**
     Subsribe to value changing.

     - Returns: Block that removes created observer. Should be placed into Disposal.
     Disposal should be flushed after observer deinit.
     */
    public func observe(_ observer: @escaping Observer) -> Disposable {
        guard let id = uniqueID.next() else { fatalError("There should always be a next unique id") }

        observers[id] = observer
        observer(value)

        let disposable = Disposable { [weak self] in
            self?.observers[id] = nil
        }

        return disposable
    }

    /// Remove all observers for Observable entity.
    public func removeAllObservers() {
        observers.removeAll()
    }

}

// MARK: - Observable extension

public extension Observable where T: Equatable {

    static func == (lhs: Observable, rhs: Observable) -> Bool {
        return lhs.value == rhs.value
    }

    func updateIfNeeded(with value: T) {
        guard self.value != value else { return }
        self.value = value
    }

}

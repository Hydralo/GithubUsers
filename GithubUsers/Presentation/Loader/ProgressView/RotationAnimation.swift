//
//  RotationAnimation.swift
//  GithubUsers
//
//  Created by Igor on 22.02.2021.
//

import UIKit

class RotationAnimation: CABasicAnimation {

    // MARK: - Nested entities

    enum Direction: String {
        case x, y, z
    }

    // MARK: - Initizalization

    override init() {
        super.init()
    }

    init(direction: Direction, fromValue: CGFloat, toValue: CGFloat, duration: Double, repeatCount: Float ) {
        super.init()
        self.keyPath = "transform.rotation.\(direction.rawValue)"
        self.fromValue = fromValue
        self.toValue = toValue
        self.duration = duration
        self.repeatCount = repeatCount
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

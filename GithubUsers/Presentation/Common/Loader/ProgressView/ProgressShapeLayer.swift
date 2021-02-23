//
//  ProgressShapeLayer.swift
//  GithubUsers
//
//  Created by Igor on 22.02.2021.
//

import UIKit

final class ProgressShapeLayer: CAShapeLayer {

    // MARK: - Initialization

    init(strokeColor: UIColor, lineWidth: CGFloat) {
        super.init()
        self.strokeColor = strokeColor.cgColor
        self.lineWidth = lineWidth
        self.fillColor = UIColor.clear.cgColor
        self.lineCap = .round
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

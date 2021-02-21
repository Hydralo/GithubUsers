//
//  ProgressView.swift
//  GithubUsers
//
//  Created by Igor on 22.02.2021.
//

import UIKit

final class ProgressView: UIView {

    private enum Constants {
        static let defaultStrokeColor: UIColor = .gray
    }

    // MARK: - Public properties

    var isAnimating: Bool = false {
        didSet {
            if isAnimating {
                self.animateStroke()
                self.animateRotation()
            } else {
                self.shapeLayer.removeFromSuperlayer()
                self.layer.removeAllAnimations()
            }
        }
    }

    // MARK: - Private properties

    private let colors: [UIColor]
    private let lineWidth: CGFloat

    private lazy var shapeLayer: ProgressShapeLayer = {
        return ProgressShapeLayer(strokeColor: colors.first ?? Constants.defaultStrokeColor, lineWidth: lineWidth)
    }()

    // MARK: - Initialization

    init(frame: CGRect, colors: [UIColor], lineWidth: CGFloat) {
        self.colors = colors
        self.lineWidth = lineWidth
        super.init(frame: frame)
        self.backgroundColor = .clear
    }

    convenience init(colors: [UIColor], lineWidth: CGFloat) {
        self.init(frame: .zero, colors: colors, lineWidth: lineWidth)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = self.frame.width / 2
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.width))
        shapeLayer.path = path.cgPath
    }

    // MARK: - Public functions

    func animateStroke() {

        let startAnimation = StrokeAnimation(
            type: .start,
            beginTime: 0.25,
            fromValue: 0.0,
            toValue: 1.0,
            duration: 0.75
        )

        let endAnimation = StrokeAnimation(
            type: .end,
            fromValue: 0.0,
            toValue: 1.0,
            duration: 0.75
        )

        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1
        strokeAnimationGroup.repeatDuration = .infinity
        strokeAnimationGroup.animations = [startAnimation, endAnimation]

        shapeLayer.add(strokeAnimationGroup, forKey: nil)

        let colorAnimation = StrokeColorAnimation(
            colors: colors.map { $0.cgColor },
            duration: strokeAnimationGroup.duration * Double(colors.count)
        )

        shapeLayer.add(colorAnimation, forKey: nil)

        self.layer.addSublayer(shapeLayer)
    }

    func animateRotation() {
        let rotationAnimation = RotationAnimation(
            direction: .z,
            fromValue: 0,
            toValue: CGFloat.pi * 2,
            duration: 2,
            repeatCount: .greatestFiniteMagnitude
        )

        self.layer.add(rotationAnimation, forKey: nil)
    }

}

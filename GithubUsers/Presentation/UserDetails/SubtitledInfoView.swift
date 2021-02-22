//
//  SubtitledInfoView.swift
//  GithubUsers
//
//  Created by Igor on 22.02.2021.
//

import UIKit

final class SubtitledInfoView: UIView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let fontSize: CGFloat = 16
    }
    
    // MARK: - Views
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.fontSize, weight: .bold)
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.fontSize, weight: .light)
        return label
    }()
    
    // MARK: - Initialization
    
    init(value: String, subtitle: String) {
        super.init(frame: .zero)
        valueLabel.text = value
        subtitleLabel.text = subtitle
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented for SubtitledInfoView")
    }
    
    // MARK: - Private functions

    private func configureLayout() {
        [valueLabel, subtitleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: topAnchor),
            valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            valueLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor),
            subtitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            subtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

}

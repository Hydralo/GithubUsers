//
//  StubView.swift
//  GithubUsers
//
//  Created by Igor on 23.02.2021.
//

import UIKit

final class StubView: UIView {
    
    typealias Completion = () -> Void
    
    // MARK: - Constants
    
    private enum Constants {
        static let image = #imageLiteral(resourceName: "ic_noData_illustration")
        static let noDataText = "Nothing to display here"
        static let retryButtonText = "Try again"
        static let buttonColor = #colorLiteral(red: 0.908448875, green: 0.9187119603, blue: 0.937394917, alpha: 1)
        static let buttonCornerRadius: CGFloat = 8
        static let imageWidth: CGFloat = 300
        static let buttonWidth: CGFloat = 150
        static let retryButtonTopInset: CGFloat = 16
        static let labelTopInset: CGFloat = 8
    }
    
    // MARK: - Views
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Constants.image
        return imageView
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.text = Constants.noDataText
        label.textAlignment = .center
        return label
    }()
    private let retryButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.backgroundColor = Constants.buttonColor
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.setTitle(Constants.retryButtonText, for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // MARK: - Private properties
    
    private var completion: Completion?
    
    // MARK: - Initialization
    
    init(completion: Completion? = nil) {
        self.completion = completion
        super.init(frame: .zero)
        configureLayout()
        guard completion != nil else { return }
        configureButtonLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented for StubView")
    }
    
    // MARK: - Private functions
    
    @objc
    private func buttonPressed() {
        completion?()
    }
    
    private func configureLayout() {
        [imageView, label].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.labelTopInset),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            label.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
        ])
    }
    
    private func configureButtonLayout() {
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(retryButton)
        
        NSLayoutConstraint.activate([
            retryButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Constants.retryButtonTopInset),
            retryButton.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            retryButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            retryButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth)
        ])
    }
    
}

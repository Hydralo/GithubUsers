//
//  ErrorController.swift
//  GithubUsers
//
//  Created by Igor on 22.02.2021.
//

import UIKit

final class ErrorController: UIViewController {
    
    typealias Completion = () -> Void
    
    // MARK: - Constants
    
    private enum Constants {
        static let image = #imageLiteral(resourceName: "ic_error_illustration")
        static let closeButtonImage = #imageLiteral(resourceName: "ic_close_button")
        static let buttonColor = #colorLiteral(red: 0.908448875, green: 0.9187119603, blue: 0.937394917, alpha: 1)
        static let buttonCornerRadius: CGFloat = 8
        static let buttonHeight: CGFloat = 44
        static let imageSize = CGSize(width: 250, height: 247)
        static let closeButtonIntest: UIEdgeInsets = .init(top: 20, left: .zero, bottom: .zero, right: -20)
        static let closeButtonSideSize: CGFloat = 28
        static let imageViewInsets = UIEdgeInsets(top: .zero, left: 62, bottom: .zero, right: -62)
        static let imageViewCenterOffset: CGFloat = -110
        static let titleLabelInsets = UIEdgeInsets(top: 56, left: 16, bottom: .zero, right: -16)
        static let subtitleLabelInsets = UIEdgeInsets(top: 16, left: 16, bottom: .zero, right: -16)
        static let buttonInsets = UIEdgeInsets(top: .zero, left: 16, bottom: -16, right: -16)
    }
    
    // MARK: - Views
    
    private let closeButton: UIButton = {
        let button: UIButton
        if #available(iOS 13.0, *) {
            button = UIButton(type: .close)
        } else {
            button = UIButton(type: .custom)
            let image = Constants.closeButtonImage
            button.setImage(image, for: .normal)
        }
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Constants.image
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textAlignment = .center
        return label
    }()
    private let button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.backgroundColor = Constants.buttonColor
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // MARK: - Private properties
    
    private let mainAction: Completion
    private let closeAction: Completion?
    
    // MARK: - Initialization
    
    init(
        title: String,
        subtitle: String,
        buttonTitle: String,
        mainAction: @escaping Completion,
        closeAction: Completion? = nil
    ) {
        self.mainAction = mainAction
        self.closeAction = closeAction
        super.init(nibName: nil, bundle: nil)
        
        titleLabel.text = title
        subtitleLabel.text = subtitle
        button.setTitle(buttonTitle, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented for ErrorController")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayout()
    }
    
    // MARK: - Private functions
    
    private func configureLayout() {
        let constraints = [
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.imageViewInsets.left),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.imageViewInsets.right),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: Constants.imageViewCenterOffset),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.titleLabelInsets.top),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: Constants.titleLabelInsets.left),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.titleLabelInsets.right),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.subtitleLabelInsets.top),
            subtitleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: Constants.subtitleLabelInsets.left),
            subtitleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.subtitleLabelInsets.right),
            
            button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.buttonInsets.left),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.buttonInsets.right),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.buttonInsets.bottom),
            
            closeButton.heightAnchor.constraint(equalToConstant: Constants.closeButtonSideSize),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.closeButtonIntest.top),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.closeButtonIntest.right)
        ]
        view.addSubviewsWithConstraints([imageView, titleLabel, subtitleLabel, button, closeButton], constraints: constraints)
    }
    
    @objc
    private func buttonPressed() {
        dismiss(animated: false)
        mainAction()
    }
    
    @objc
    private func closeButtonPressed() {
        dismiss(animated: false)
        closeAction?()
    }
    
}

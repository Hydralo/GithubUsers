//
//  LoaderViewController.swift
//  GithubUsers
//
//  Created by Igor on 22.02.2021.
//

import UIKit

final class LoaderViewController: UIViewController {

    private enum Constants {
        static let loaderColors: [UIColor] = [#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)]
        static let loaderLineWidth: CGFloat = 5
        static let loaderSideSize: CGFloat = 50
    }

    // MARK: - Private properties

    private let loadingIndicator: ProgressView = {
        let progress = ProgressView(colors: Constants.loaderColors, lineWidth: Constants.loaderLineWidth)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadingIndicator.isAnimating = true
    }

    // MARK: - Private functions

    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }

        self.view.backgroundColor = .clear
        self.view.addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: Constants.loaderSideSize),
            loadingIndicator.heightAnchor.constraint(equalTo: self.loadingIndicator.widthAnchor)
        ])
    }

}

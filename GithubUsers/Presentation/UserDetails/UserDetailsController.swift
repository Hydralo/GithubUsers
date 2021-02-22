//
//  UserDetailsController.swift
//  GithubUsers
//
//  Created by Igor on 22.02.2021.
//

import UIKit

final class UserDetailsController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let imageCornerRadius: CGFloat = 6
        static let imageSideSize: CGFloat = 104
        static let imageViewInsets = UIEdgeInsets(top: 8, left: 16, bottom: .zero, right: .zero)
        static let verticalStackInsets = UIEdgeInsets(top: 8, left: 8, bottom: -8, right: -8)
        static let bioLabelInsets = UIEdgeInsets(top: 16, left: 16, bottom: -16, right: -8)
        static let avatarPlaceholder = #imageLiteral(resourceName: "ic_avatar_placeholder")
        static let subtitle = (repos: "Public repos", following: "Followers", followers: "Following")
        static let bioLabelText = "Bio: "
    }
    
    // MARK: - Views
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = Constants.imageCornerRadius
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    private let horizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        return stackView
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Private properties
    
    private let viewModel: IUserDetailsViewModel
    private var disposal = Disposal()
    
    // MARK: - Initialization
    
    init(viewModel: IUserDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        configureLayout()
        configureVerticalStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented for UserDetailsController")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.userName
        bindViewModel()
        viewModel.load()
    }
    
    // MARK: - Private functions

    private func bindViewModel() {
        viewModel.userInfo.observe { [weak self] userInfo in
            guard let userInfo = userInfo else { return }
            self?.nameLabel.text = userInfo.textInfo.name
            self?.configureHorizontalStack(
                publicRepoCount: userInfo.quantitativeInfo.publicRepoCount,
                followers: userInfo.quantitativeInfo.followers,
                following: userInfo.quantitativeInfo.following
            )
            guard let bio = userInfo.textInfo.bio else { return }
            self?.bioLabel.text = Constants.bioLabelText + bio
        }.add(to: &disposal)

        viewModel.avatarImage.observe { [weak self] image in
            self?.imageView.image = image ?? Constants.avatarPlaceholder
        }.add(to: &disposal)
    }
    
    private func configureLayout() {
        view.backgroundColor = .white
        [imageView, verticalStack, bioLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.imageViewInsets.left
            ),
            imageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.imageViewInsets.top
            ),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageSideSize),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            verticalStack.leadingAnchor.constraint(
                equalTo: imageView.trailingAnchor,
                constant: Constants.verticalStackInsets.left
            ),
            verticalStack.topAnchor.constraint(
                equalTo: imageView.topAnchor,
                constant: Constants.verticalStackInsets.top
            ),
            verticalStack.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Constants.verticalStackInsets.right
            ),
            verticalStack.bottomAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: Constants.verticalStackInsets.bottom
            ),
            
            bioLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.bioLabelInsets.left
            ),
            bioLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Constants.bioLabelInsets.right
            ),
            bioLabel.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: Constants.bioLabelInsets.top
            ),
            bioLabel.bottomAnchor.constraint(
                lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: Constants.bioLabelInsets.bottom
            )
        ])
    }
    
    private func configureVerticalStack() {
        [nameLabel, horizontalStack].forEach { verticalStack.addArrangedSubview($0) }
    }
    
    private func configureHorizontalStack(publicRepoCount: Int, followers: Int, following: Int) {
        createTextInfoViews(
            publicRepoCount: publicRepoCount,
            followers: followers,
            following: following).forEach {
                horizontalStack.addArrangedSubview($0)
            }
    }
    
    private func createTextInfoViews(publicRepoCount: Int, followers: Int, following: Int) -> [UIView] {
        [
            SubtitledInfoView(value: String(publicRepoCount), subtitle: Constants.subtitle.repos),
            SubtitledInfoView(value: String(followers), subtitle: Constants.subtitle.followers),
            SubtitledInfoView(value: String(following), subtitle: Constants.subtitle.following)
        ]
        
    }

}

//
//  UserFeedCell.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import UIKit

final class UserFeedCell: UICollectionViewCell {
    
    private enum Constants {
        static let imageCornerRadius: CGFloat = 6
        static let imageSideSize: CGFloat = 104
        static let imageViewInsets: UIEdgeInsets = .init(top: 8, left: 16, bottom: -8, right: .zero)
        static let nameLabelInsets: UIEdgeInsets = .init(top: .zero, left: 16, bottom: .zero, right: -16)
        static let avatarPlaceholder = #imageLiteral(resourceName: "ic_avatar_placeholder")
    }
    
    // MARK: - Views
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = Constants.imageCornerRadius
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    // MARK: - Private properties
    
    private var disposal = Disposal()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented for UserFeedCell")
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // TODO: - Cancel image loading request
    }
    
    // MARK: - Functions
    
    func configure(with viewModel: IUserFeedCellViewModel) {
        contentView.backgroundColor = .white
        nameLabel.text = viewModel.name
        bindViewModel(viewModel)
    }
    
    // MARK: - Private functions
    
    private func bindViewModel(_ viewModel: IUserFeedCellViewModel) {
        viewModel.avatarImage.observe { [weak self] image in
            self?.imageView.image = image ?? Constants.avatarPlaceholder
        }.add(to: &disposal)
    }
    
    private func configureLayout() {
        [imageView, nameLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.imageViewInsets.left),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.imageViewInsets.top),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.imageViewInsets.bottom),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageSideSize),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.nameLabelInsets.left),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.nameLabelInsets.right)
        ])
    }
    
}

//
//  UsersFeedController.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import UIKit

final class UsersFeedController: UIViewController {
    
    // MARK: - Private properties
    
    private let viewModel: IUsersFeedViewModel
    
    // MARK: - Initialization
    
    init(viewModel: IUsersFeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented for UsersFeedController")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        viewModel.load()
    }
    
}

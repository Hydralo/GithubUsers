//
//  UICollectionView+Extensions.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import UIKit

extension UICollectionView {
    func registerCell(_ cellClass: UICollectionViewCell.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }
    
    func dequeueConfigurableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T? {
        self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T
    }
}

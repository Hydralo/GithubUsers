//
//  UIView+reuseIdentifier.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import UIKit

extension UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    func addSubviewsWithConstraints(_ views: [UIView], constraints: [NSLayoutConstraint]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func addFrameEqualityConstraints(to view: UIView, withMargins margins: UIEdgeInsets = .zero) {
        let rules = ["H:|-\(margins.left)-[v]-\(margins.right)-|", "V:|-\(margins.top)-[v]-\(margins.bottom)-|"]
        let views = ["v": view]
        for rule in rules {
            let constraints = NSLayoutConstraint.constraints(withVisualFormat: rule, options: [], metrics: nil, views: views)
            addConstraints(constraints)
        }
    }

    func addFrameEqualitySubview(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        addFrameEqualityConstraints(to: subview)
    }
}


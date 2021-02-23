//
//  UIViewController+children.swift
//  GithubUsers
//
//  Created by Igor on 22.02.2021.
//

import UIKit

extension UIViewController {

    func embed(_ child: UIViewController, animated: Bool) {
        let childAddingBlock = {
            self.addChild(child)
            self.view.addSubview(child.view)
        }
        animated ? performAnimatedTransition(childAddingBlock) : childAddingBlock()
        child.didMove(toParent: self)
    }

    func unembed() {
        guard parent != nil else { return }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    private func performAnimatedTransition(_ block: @escaping () -> Void) {
        UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromLeft, animations: block, completion: nil)
    }

}

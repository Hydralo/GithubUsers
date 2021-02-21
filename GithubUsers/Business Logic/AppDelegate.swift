//
//  AppDelegate.swift
//  GithubUsers
//
//  Created by Igor on 21.02.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    
    var window: UIWindow?
    
    // MARK: - Private properties
    
    private let launchManager: ILaunchAppManager = LaunchAppManager()
    
    // MARK: - Application lifecycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = launchManager.generateWindow()
        return true
    }

}


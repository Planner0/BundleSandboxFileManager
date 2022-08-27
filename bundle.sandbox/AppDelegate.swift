//
//  AppDelegate.swift
//  bundle.sandbox
//
//  Created by ALEKSANDR POZDNIKIN on 14.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        let viewController = ViewController()
        let navigationVC = UINavigationController()
        
        navigationVC.pushViewController(viewController, animated: true)
        
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationVC
        return true
    }
}


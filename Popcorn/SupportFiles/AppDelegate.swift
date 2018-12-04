//
//  AppDelegate.swift
//  Popcorn
//
//  Created by Marijn Schilling on 04/12/2018.
//  Copyright © 2018 Marijn Schilling. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = self.window else { fatalError("Window not found") }

        window.rootViewController = UINavigationController(rootViewController: UIViewController())

        window.makeKeyAndVisible()

        return true
    }
}

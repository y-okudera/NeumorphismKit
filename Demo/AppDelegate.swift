//
//  AppDelegate.swift
//  Demo
//
//  Created by okudera on 2020/08/18.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit
import NeumorphismKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // Set neumorphism base color
        NeumorphismAppearance.shared.baseColor = UIColor(red: 205 / 255, green: 230 / 255, blue: 240 / 255, alpha: 1.0)

        // NeumorphismTabBar title and icon color when unselected
        NeumorphismAppearance.shared.tabBarItem.defaultTint = .darkGray

        // NeumorphismTabBar title and icon color when selected
        NeumorphismAppearance.shared.tabBarItem.selectedTint = .orange
        return true
    }
}

//
//  TabBarController.swift
//  Demo
//
//  Created by okudera on 2020/10/14.
//  Copyright © 2020 yuoku. All rights reserved.
//

import NeumorphismKit
import UIKit

class TabBarController: NeumorphismTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.nskDelegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // If it is an empty string, the title will be hidden.
        let btn1 = NeumorphismTabBarItem(title: "", icon: UIImage(named: "tab_activity")!)
        let btn2 = NeumorphismTabBarItem(title: "", icon: UIImage(named: "tab_game")!)
        let btn3 = NeumorphismTabBarItem(title: "", icon: UIImage(named: "tab_my_page")!)
        let btn4 = NeumorphismTabBarItem(title: "Timeline", icon: UIImage(named: "tab_timeline")!)
        let btn5 = NeumorphismTabBarItem(title: "Users", icon: UIImage(named: "tab_users")!)

        self.setup(viewControllers: [
            (viewController: MainViewController.instantiate(), tabBarItem: btn1),
            (viewController: OtherViewController.instantiate(text: "View1"), tabBarItem: btn2),
            (viewController: OtherViewController.instantiate(text: "View2"), tabBarItem: btn3),
            (viewController: OtherViewController.instantiate(text: "View3"), tabBarItem: btn4),
            (viewController: OtherViewController.instantiate(text: "View4"), tabBarItem: btn5),
        ])
    }
}

extension TabBarController: NeumorphismTabBarControllerDelegate {
    func finishedSwitchingTab(fromIndex: Int, toIndex: Int) {
        print("fromIndex: \(fromIndex) toIndex: \(toIndex)")
    }
}

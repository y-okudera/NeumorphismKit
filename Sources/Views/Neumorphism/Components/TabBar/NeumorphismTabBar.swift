//
//  NeumorphismTabBar.swift
//  NeumorphismKit
//
//  Created by okudera on 2020/10/14.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

public class NeumorphismTabBar: UITabBar {

    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.height = NeumorphismTabBarController.tabBarHeight
        return size
    }

    func updateAppearance(baseColor: UIColor) {

        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(baseColor.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        UITabBar.appearance().backgroundImage = image
        UITabBar.appearance().shadowImage = image
    }
}

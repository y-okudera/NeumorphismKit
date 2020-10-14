//
//  NeumorphismAppearance.swift
//  NeumorphismKit
//
//  Created by okudera on 2020/08/19.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

public final class NeumorphismTabBarItemAppearance {

    /// Title and icon color when unselected
    public var defaultTint: UIColor = .lightGray

    /// Title and icon color when selected
    public var selectedTint: UIColor = .blue

    public var titleFont: UIFont = .systemFont(ofSize: 11)

    public var titleMinimumScaleFactor: CGFloat = 0.75
}

public final class NeumorphismAppearance {

    private init() {}

    public static let shared = NeumorphismAppearance()

    public var baseColor: UIColor = .white
    public var tabBarItem: NeumorphismTabBarItemAppearance = .init()
}

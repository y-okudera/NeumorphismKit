//
//  NeumorphismTabBarController.swift
//  NeumorphismKit
//
//  Created by okudera on 2020/10/04.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

public protocol NeumorphismTabBarControllerDelegate: AnyObject {
    func finishedSwitchingTab(fromIndex: Int, toIndex: Int)
}

@IBDesignable
open class NeumorphismTabBarController: UITabBarController {

    static var tabBarHeight = CGFloat(49.0)

    public weak var nskDelegate: NeumorphismTabBarControllerDelegate?

    private var neumorphismTabView: NeumorphismTabView!
    private var _baseColor: UIColor = NeumorphismAppearance.shared.baseColor
    private var _sideMargin: CGFloat = 24.0
    private var _bottomMargin: CGFloat = 16.0

    /// NeumorphismTabBarItem cornerRadius
    public var _itemsCornerRadius: CGFloat = 8.0
    /// NeumorphismTabBarItem cornerRadius
    public var _tabViewsCornerRadius: CGFloat = 20.0

    @IBInspectable
    open var baseColor: UIColor = NeumorphismAppearance.shared.baseColor {
        willSet {
            _baseColor = newValue
        }
    }

    @IBInspectable
    open var sideMargin: CGFloat = 24.0 {
        willSet {
            _sideMargin = newValue
        }
    }

    @IBInspectable
    open var bottomMargin: CGFloat = 16.0 {
        willSet {
            _bottomMargin = newValue
        }
    }

    @IBInspectable
    open var itemsCornerRadius: CGFloat = 8.0 {
        willSet {
            _itemsCornerRadius = newValue
        }
    }

    @IBInspectable
    open var tabViewsCornerRadius: CGFloat = 20.0 {
        willSet {
            _tabViewsCornerRadius = newValue
        }
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        if let neumorphismTabBar = self.tabBar as? NeumorphismTabBar {
            neumorphismTabBar.updateAppearance(baseColor: _baseColor)
        }
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupNeumorphism()
    }

    /// Set tabBarItem and viewController.
    public func setup(viewControllers: [(viewController: UIViewController, tabBarItem: NeumorphismTabBarItem)]) {
        self.setTabBar(items: viewControllers.map { $0.tabBarItem })
        self.viewControllers = viewControllers.map { $0.viewController }
    }

    /// Set up tab bar.
    func setTabBar(items: [NeumorphismTabBarItem], height: CGFloat = 70.0) {

        guard items.count > 0 else { return }
        self.neumorphismTabView = NeumorphismTabView(items: items, itemHorizontalMargin: 32.0 / CGFloat(items.count), itemVerticalMargin: 10.0)
        self.neumorphismTabView.items.first?.isSelected = true

        self.view.addSubview(self.neumorphismTabView)

        self.neumorphismTabView.translatesAutoresizingMaskIntoConstraints = false
        self.neumorphismTabView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0).isActive = true
        self.neumorphismTabView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0).isActive = true
        self.neumorphismTabView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -self.bottomMargin).isActive = true
        self.neumorphismTabView.heightAnchor.constraint(equalToConstant: height).isActive = true

        for (index, _) in items.enumerated() {
            items[index].tag = index
            items[index].addTarget(self, action: #selector(self.switchTab(button:)), for: .touchUpInside)
        }

        NeumorphismTabBarController.tabBarHeight = height + _bottomMargin

        self.view.layoutIfNeeded()
    }

    @objc func switchTab(button: UIButton) {
        let fromIndex = self.selectedIndex
        let newIndex = button.tag
        self.moveTab(fromIndex: self.selectedIndex, toIndex: newIndex)
        self.nskDelegate?.finishedSwitchingTab(fromIndex: fromIndex, toIndex: newIndex)
    }

    func moveTab(fromIndex: Int, toIndex: Int) {

        self.neumorphismTabView.items[fromIndex].isSelected = false
        self.neumorphismTabView.items[toIndex].isSelected = true

        guard fromIndex != toIndex else {
            return
        }
        guard let fromController = viewControllers?[fromIndex], let toController = viewControllers?[toIndex] else {
            return
        }
        let fromView = fromController.view!
        let toView = toController.view!
        let viewSize = fromView.frame
        fromView.superview?.addSubview(toView)
        toView.frame = CGRect(x: 0, y: viewSize.origin.y, width: UIScreen.main.bounds.width, height: viewSize.height)
        fromView.removeFromSuperview()
        self.selectedIndex = toIndex
    }

    private func setupNeumorphism() {
        self.tabBar.nsk.removeLayers()
        self.neumorphismTabView?.updateNeumorphism(baseColor: _baseColor, cornerRadius: _tabViewsCornerRadius, itemsCornerRadius: _itemsCornerRadius)
    }
}

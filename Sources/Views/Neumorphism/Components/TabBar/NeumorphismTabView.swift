//
//  NeumorphismTabView.swift
//  NeumorphismKit
//
//  Created by okudera on 2020/10/12.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

public class NeumorphismTabView: UIView {

    private let stackView = UIStackView()
    private(set) var items = [NeumorphismTabBarItem]()

    private var baseColor: UIColor = NeumorphismAppearance.shared.baseColor
    private var cornerRadius: CGFloat = 20.0

    /// NeumorphismTabBarItem cornerRadius
    public var itemsCornerRadius: CGFloat = 8.0

    public convenience init(items: [NeumorphismTabBarItem], itemHorizontalMargin: CGFloat, itemVerticalMargin: CGFloat) {
        self.init()
        self.items = items
        translatesAutoresizingMaskIntoConstraints = false
        setupView(itemHorizontalMargin: itemHorizontalMargin, itemVerticalMargin: itemVerticalMargin)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        setupNeumorphism()
    }

    func setupView(itemHorizontalMargin: CGFloat, itemVerticalMargin: CGFloat) {
        if self.items.isEmpty {
            return
        }

        self.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .horizontal
        self.stackView.distribution = .fillEqually
        self.stackView.alignment = .fill
        self.stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: itemHorizontalMargin).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -itemHorizontalMargin).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: itemVerticalMargin).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -itemVerticalMargin).isActive = true

        for item in self.items {
            self.stackView.addArrangedSubview(item)
        }
    }

    // MARK: - Neumorphism

    func updateNeumorphism(baseColor: UIColor, cornerRadius: CGFloat, itemsCornerRadius: CGFloat) {
        self.baseColor = baseColor
        self.cornerRadius = cornerRadius
        self.itemsCornerRadius = itemsCornerRadius
        self.setupNeumorphism()
    }

    private func setupNeumorphism() {
        self.nsk.removeLayers()
        let baseColorRGB = self.baseColor.convertToRGB()
        self.nsk.convexNeumorphism(r: baseColorRGB.red, g: baseColorRGB.green, b: baseColorRGB.blue, cornerRadius: self.cornerRadius, shadowRadius: 0)
        self.items.forEach {
            $0.updateNeumorphism(baseColor: self.baseColor, cornerRadius: itemsCornerRadius)
        }
    }
}

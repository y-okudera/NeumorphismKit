//
//  NeumorphismTabBarItem.swift
//  NeumorphismKit
//
//  Created by okudera on 2020/10/12.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

public class NeumorphismTabBarItem: UIButton {

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    private let stackView = UIStackView()

    private var defaultTint: UIColor?
    private var selectedTint: UIColor?
    private var baseColor: UIColor = NeumorphismAppearance.shared.baseColor
    private var cornerRadius: CGFloat = 8.0

    // MARK: - Initializer
    public convenience init(title: String, icon: UIImage) {
        self.init()
        self.defaultTint = NeumorphismAppearance.shared.tabBarItem.defaultTint
        self.selectedTint = NeumorphismAppearance.shared.tabBarItem.selectedTint
        self.setupView(title: title, icon: icon)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.setupNeumorphism()
    }

    public override var isSelected: Bool {
        didSet {
            if isSelected {
                self.iconImageView.tintColor = self.selectedTint
                self.textLabel.textColor = self.selectedTint
                self.textLabel.tintColor = self.selectedTint
            }
            else {
                self.iconImageView.tintColor = self.defaultTint
                self.textLabel.textColor = self.defaultTint
                self.textLabel.tintColor = self.defaultTint
            }
        }
    }

    private func setupView(title: String, icon: UIImage) {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.textLabel.text = title
        self.textLabel.font = NeumorphismAppearance.shared.tabBarItem.titleFont
        self.textLabel.textColor = NeumorphismAppearance.shared.tabBarItem.defaultTint
        self.textLabel.tintColor = NeumorphismAppearance.shared.tabBarItem.defaultTint
        self.textLabel.adjustsFontSizeToFitWidth = true
        self.textLabel.minimumScaleFactor = NeumorphismAppearance.shared.tabBarItem.titleMinimumScaleFactor

        self.iconImageView.image = icon.withRenderingMode(.alwaysTemplate)
        self.iconImageView.tintColor = NeumorphismAppearance.shared.tabBarItem.defaultTint

        if (self.textLabel.text ?? "").isEmpty {
            self.textLabel.isHidden = true
            self.iconImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        else {
            self.textLabel.isHidden = false
            self.iconImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }

        self.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.stackView.distribution = .fill
        self.stackView.alignment = .fill
        self.stackView.spacing = 4.0
        self.stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4.0).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4.0).isActive = true
        self.stackView.addArrangedSubview(self.iconImageView)
        self.stackView.addArrangedSubview(self.textLabel)
        self.stackView.isUserInteractionEnabled = false
    }

    // MARK: - Neumorphism

    func updateNeumorphism(baseColor: UIColor, cornerRadius: CGFloat) {
        self.baseColor = baseColor
        self.cornerRadius = cornerRadius
        self.setupNeumorphism()
    }

    private func setupNeumorphism() {
        self.nsk.removeLayers()

        let baseColorRGB = self.baseColor.convertToRGB()
        if self.isSelected {
            self.nsk.concaveNeumorphism(r: baseColorRGB.red, g: baseColorRGB.green, b: baseColorRGB.blue, cornerRadius: self.cornerRadius, shadowRadius: 4)
        }
        else {
            self.nsk.convexNeumorphism(r: baseColorRGB.red, g: baseColorRGB.green, b: baseColorRGB.blue, cornerRadius: self.cornerRadius, shadowRadius: 4)
        }
    }
}

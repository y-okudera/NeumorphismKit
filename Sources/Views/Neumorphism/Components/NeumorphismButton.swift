//
//  NeumorphismButton.swift
//  NeumorphismKit
//
//  Created by okudera on 2020/08/18.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

@IBDesignable
public class NeumorphismButton: UIButton {

    private var neumorphismType: NeumorphismType = .convex {
        didSet {
            self.setupNeumorphism()
        }
    }

    private var _baseColor: UIColor = NeumorphismAppearance.shared.baseColor
    private var _cornerRadius: CGFloat = 16.0

    @IBInspectable
    public var baseColor: UIColor = NeumorphismAppearance.shared.baseColor {
        willSet {
            _baseColor = newValue
            self.setupNeumorphism()
        }
    }

    @IBInspectable
    public var cornerRadius: CGFloat = 16.0 {
        willSet {
            _cornerRadius = newValue
            self.setupNeumorphism()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupNeumorphism()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNeumorphism()
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupNeumorphism()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.setupNeumorphism()
    }

    public override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.neumorphismType = .concave
            }
            else {
                self.neumorphismType = .convex
            }
        }
    }

    private func setupNeumorphism() {
        self.nsk.removeLayers()

        let baseColorRGB = _baseColor.convertToRGB()
        switch neumorphismType {
        case .convex:
            self.nsk.convexNeumorphism(r: baseColorRGB.red, g: baseColorRGB.green, b: baseColorRGB.blue, cornerRadius: _cornerRadius)
        case .concave:
            self.nsk.concaveNeumorphism(r: baseColorRGB.red, g: baseColorRGB.green, b: baseColorRGB.blue, cornerRadius: _cornerRadius)
        }
    }
}

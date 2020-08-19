//
//  NeumorphismTextView.swift
//  NeumorphismKit
//
//  Created by okudera on 2020/08/19.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

@IBDesignable
public class NeumorphismTextView: UITextView {

    private var _baseColor: UIColor = NeumorphismAppearance.shared.baseColor
    private var _cornerRadius: CGFloat = 16.0
    private var _neumorphismType: NeumorphismType = .concave

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

    @IBInspectable
    public var isConvex: Bool = false {
        willSet {
            _neumorphismType = newValue ? .convex : .concave
            self.setupNeumorphism()
        }
    }

    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.setupNeumorphism()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNeumorphism()
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupNeumorphism()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.setupNeumorphism()
    }

    private func setupNeumorphism() {
        self.nsk.removeLayers()

        self.backgroundColor = .clear

        self.layer.cornerRadius = _cornerRadius
        self.layer.masksToBounds = _cornerRadius > 0

        self.layer.borderColor = _baseColor.cgColor
        self.layer.borderWidth = 1.0

        let baseColorRGB = _baseColor.convertToRGB()
        switch _neumorphismType {
        case .convex:
            self.nsk.convexNeumorphism(r: baseColorRGB.red, g: baseColorRGB.green, b: baseColorRGB.blue, cornerRadius: _cornerRadius)
        case .concave:
            self.nsk.concaveNeumorphism(r: baseColorRGB.red, g: baseColorRGB.green, b: baseColorRGB.blue, cornerRadius: _cornerRadius)
        }
    }
}

//
//  NeumorphismLabel.swift
//  NeumorphismKit
//
//  Created by okudera on 2020/08/19.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

@IBDesignable
public class NeumorphismLabel: UILabel {

    private var textDisplayableLabel: UILabel?
    private var _baseColor: UIColor = NeumorphismAppearance.shared.baseColor
    private var _cornerRadius: CGFloat = 8.0
    private var _neumorphismType: NeumorphismType = .convex

    @IBInspectable
    public var baseColor: UIColor = NeumorphismAppearance.shared.baseColor {
        willSet {
            _baseColor = newValue
            self.setupNeumorphism()
        }
    }

    @IBInspectable
    public var cornerRadius: CGFloat = 8.0 {
        willSet {
            _cornerRadius = newValue
            self.setupNeumorphism()
        }
    }

    @IBInspectable
    public var isConvex: Bool = true {
        willSet {
            _neumorphismType = newValue ? .convex : .concave
            self.setupNeumorphism()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
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

    public override var text: String? {
        didSet {
            addTextDisplayableLabel()
        }
    }

    private func setupNeumorphism() {
        self.nsk.removeLayers()

        let baseColorRGB = _baseColor.convertToRGB()
        switch _neumorphismType {
        case .convex:
            self.nsk.convexNeumorphism(r: baseColorRGB.red, g: baseColorRGB.green, b: baseColorRGB.blue, cornerRadius: _cornerRadius)
        case .concave:
            self.nsk.concaveNeumorphism(r: baseColorRGB.red, g: baseColorRGB.green, b: baseColorRGB.blue, cornerRadius: _cornerRadius)
        }
        self.addTextDisplayableLabel()
    }

    private func addTextDisplayableLabel() {
        if let textLabel = self.textDisplayableLabel {
            textLabel.removeFromSuperview()
        }
        self.textDisplayableLabel = UILabel(frame: .init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        self.textDisplayableLabel?.backgroundColor = .clear
        self.textDisplayableLabel?.text = self.text
        self.textDisplayableLabel?.font = self.font
        self.textDisplayableLabel?.textColor = self.textColor
        self.textDisplayableLabel?.textAlignment = self.textAlignment
        self.textDisplayableLabel?.numberOfLines = self.numberOfLines
        self.addSubview(self.textDisplayableLabel!)
    }
}

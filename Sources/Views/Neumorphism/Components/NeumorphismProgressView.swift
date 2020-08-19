//
//  NeumorphismProgressView.swift
//  NeumorphismKit
//
//  Created by okudera on 2020/08/19.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

@IBDesignable
public class NeumorphismProgressView: UIProgressView {

    private var _baseColor: UIColor = NeumorphismAppearance.shared.baseColor
    private var _cornerRadius: CGFloat = 8.0
    private var _neumorphismType: NeumorphismType = .concave
    private var _progressColor: UIColor = .systemGreen

    private var updateProgress: Bool = false

    @IBInspectable
    public var baseColor: UIColor = NeumorphismAppearance.shared.baseColor {
        willSet {
            _baseColor = newValue
            self.setupNeumorphism()
        }
    }

    @IBInspectable
    public var cornerRadius: CGFloat = .zero {
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

    @IBInspectable
    public var progressColor: UIColor = .systemGreen {
        willSet {
            _progressColor = newValue
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
        if !self.updateProgress {
            self.setupNeumorphism()
        }
        self.updateProgress = false
    }

    private func setupNeumorphism() {
        self.nsk.removeLayers()
        self.tintColor = self._progressColor

        self.layer.cornerRadius = self.bounds.height / 2
        self.clipsToBounds = true

        self.layer.sublayers?[safe: 0]?.cornerRadius = self.bounds.height / 2
        self.subviews[safe: 0]?.clipsToBounds = true

        self.layer.sublayers?[safe: 1]?.cornerRadius = self.bounds.height / 2
        self.subviews[safe: 1]?.clipsToBounds = true

        let baseColorRGB = self._baseColor.convertToRGB()
        switch self._neumorphismType {
        case .convex:
            self.subviews[0].nsk.convexNeumorphism(r: baseColorRGB.red, g: baseColorRGB.green, b: baseColorRGB.blue, cornerRadius: self._cornerRadius)
        case .concave:
            self.subviews[0].nsk.concaveNeumorphism(r: baseColorRGB.red, g: baseColorRGB.green, b: baseColorRGB.blue, cornerRadius: self._cornerRadius)
        }
    }
}

public extension NeumorphismProgressView {

    func setProgress(_ progress: Float) {
        self.updateProgress = true
        self.progress = progress
    }

    func incrementProgress(_ progress: Float) {
        self.setProgress(self.progress + progress)
        if self.progress > 1.0 {
            self.setProgress(1.0)
        }
    }

    func decrementProgress(_ progress: Float) {
        self.setProgress(self.progress - progress)
        if self.progress < 0.0 {
            self.setProgress(0.0)
        }
    }
}

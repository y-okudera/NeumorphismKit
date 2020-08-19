//
//  UIView+.swift
//  NeumorphismKit
//
//  Created by okudera on 2020/08/18.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

extension UIView: ExtensionCompatible {}

public extension Extension where Base: UIView {

    /// Remove concave layers and convex layers.
    func removeLayers() {
        base.concaveLayers.forEach {
            $0.removeFromSuperlayer()
        }
        base.concaveLayers = []
        base.convexLayers.forEach {
            $0.removeFromSuperlayer()
        }
        base.convexLayers = []
    }

    /// Remove concave layers.
    func removeConcaveLayers() {
        base.concaveLayers.forEach {
            $0.removeFromSuperlayer()
        }
        base.concaveLayers = []
    }

    /// Remove convex layers.
    func removeConvexLayers() {
        base.convexLayers.forEach {
            $0.removeFromSuperlayer()
        }
        base.convexLayers = []
    }

    /// Set convex layers. (凸型)
    /// - Parameters:
    ///   - r: Background red
    ///   - g: Background green
    ///   - b: Background blue
    ///   - cornerRadius: Corner radius
    ///   - shadowRadius: Shadow radius
    func convexNeumorphism(r: CGFloat, g: CGFloat, b: CGFloat, cornerRadius: CGFloat, shadowRadius: CGFloat = 10.0) {
        let backGroundColor = UIColor(displayP3Red: r / 255, green: g / 255, blue: b / 255, alpha: 1.0)
        let darkcolor = neumorphismShadow(defaultcolor: backGroundColor, shadowType: .dark)
        let lightcolor = neumorphismShadow(defaultcolor: backGroundColor, shadowType: .light)
        
        addBackground(color: backGroundColor, cornerRadius: cornerRadius)
        addOuterShadow(
            shadowColor: darkcolor.cgColor,
            shadowOffset: .init(width: 4.0, height: 4.0),
            cornerRadius: cornerRadius,
            shadowOpacity: 1.0,
            shadowRadius: shadowRadius
        )
        addOuterShadow(
            shadowColor: lightcolor.cgColor,
            shadowOffset: .init(width: -4.0, height: -4.0),
            cornerRadius: cornerRadius,
            shadowOpacity: 1.0,
            shadowRadius: shadowRadius
        )
    }

    /// Set concave layers. (凹型)
    /// - Parameters:
    ///   - r: Background red
    ///   - g: Background green
    ///   - b: Background blue
    ///   - cornerRadius: Corner radius
    ///   - shadowRadius: Shadow radius
    func concaveNeumorphism(r: CGFloat, g: CGFloat, b: CGFloat, cornerRadius: CGFloat, shadowRadius: CGFloat = 10.0) {
        let backGroundColor = UIColor(displayP3Red: r / 255, green: g / 255, blue: b / 255, alpha: 1.0)
        let darkcolor = neumorphismShadow(defaultcolor: backGroundColor, shadowType: .dark)
        let lightcolor = neumorphismShadow(defaultcolor: backGroundColor, shadowType: .light)
        
        addInnerShadow(
            fillColor: backGroundColor.cgColor,
            shadowColor: darkcolor.cgColor,
            cornerRadius: cornerRadius,
            shadowOffset: .init(width: 4.0, height: 4.0),
            shadowOpacity: 1.0,
            shadowRadius: shadowRadius
        )
        addInnerShadow(
            fillColor: backGroundColor.cgColor,
            shadowColor: lightcolor.cgColor,
            cornerRadius: cornerRadius,
            shadowOffset: .init(width: -4.0, height: -4.0),
            shadowOpacity: 1.0,
            shadowRadius: shadowRadius
        )
    }
}

private extension Extension where Base: UIView {
    
    // MARK: - Neumorphism common
    
    /// Get neumorphism shadow color.
    func neumorphismShadow(defaultcolor: UIColor, shadowType: NeumorphismShadowType) -> UIColor {
        var color = defaultcolor
        var hue = CGFloat.zero
        var saturation = CGFloat.zero
        var brightness = CGFloat.zero
        var alpha = CGFloat.zero
        if color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            var brightRate = CGFloat.zero
            switch shadowType {
            case .dark:
                brightRate = 0.90
            case .light:
                brightRate = 1.10
            }
            color = UIColor(hue: hue, saturation: saturation, brightness: brightness * brightRate, alpha: alpha)
        }
        return color
    }
    
    // MARK: - Convex (凸型)

    /// Add background color for convex neumorphism. (凸型)
    func addBackground(color: UIColor, cornerRadius: CGFloat) {
        let background = CALayer()
        background.backgroundColor = color.cgColor
        background.cornerRadius = cornerRadius
        background.frame.size = CGSize(width: base.frame.size.width, height: base.frame.size.height)
        base.layer.insertSublayer(background, at: 0)
        base.convexLayers.append(background)
    }

    /// Add outer shadow for convex neumorphism. (凸型)
    func addOuterShadow(shadowColor: CGColor, shadowOffset: CGSize, cornerRadius: CGFloat, shadowOpacity: Float, shadowRadius: CGFloat) {
        let layer = CALayer()
        layer.masksToBounds = false
        layer.shadowColor = shadowColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowPath = UIBezierPath(roundedRect: base.bounds, cornerRadius: cornerRadius).cgPath
        base.layer.insertSublayer(layer, at: 0)
        base.convexLayers.append(layer)
    }

    // MARK: - Concave (凹型)

    /// Add Inner shadow for concave neumorphism. (凹型)
    func addInnerShadow(fillColor: CGColor, shadowColor: CGColor, cornerRadius: CGFloat, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat) {
        let layer = CAShapeLayer()
        layer.backgroundColor = UIColor.clear.cgColor
        layer.fillColor = fillColor
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.fillRule = .evenOdd
        
        let layerPath = UIBezierPath(roundedRect: base.bounds.insetBy(dx: -100.0, dy: -100.0), cornerRadius: cornerRadius)
        layerPath.append(UIBezierPath(roundedRect: base.bounds, cornerRadius: cornerRadius))
        layer.path = layerPath.cgPath
        
        let layerMask = CAShapeLayer()
        layerMask.path = UIBezierPath(roundedRect: base.bounds, cornerRadius: cornerRadius).cgPath
        layer.mask = layerMask
        
        base.layer.insertSublayer(layer, at: 0)
        base.concaveLayers.append(layer)
    }
}

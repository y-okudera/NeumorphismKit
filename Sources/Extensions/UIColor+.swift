//
//  UIColor+.swift
//  NeumorphismKit
//
//  Created by okudera on 2020/08/18.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

extension UIColor {

    /// Get RGB and alpha values. ( 0.0 to 255.0)
    func convertToRGB() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 1.0
        var green: CGFloat = 1.0
        var blue: CGFloat = 1.0
        var alpha: CGFloat = 1.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        red = round(red * 255.0 * 1000) / 1000
        green = round(green * 255.0 * 1000) / 1000
        blue = round(blue * 255.0 * 1000) / 1000
        return (red: red, green: green, blue: blue, alpha: alpha)
    }
}

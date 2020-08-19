//
//  NeumorphismCompatible.swift
//  NeumorphismKit
//
//  Created by okudera on 2020/08/18.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit
import ObjectiveC

private var concaveLayersContext: UInt8 = 0
private var convexLayersContext: UInt8 = 1

public protocol NeumorphismCompatible: AnyObject {
    /// concave layers (凹型)
    var concaveLayers: [CALayer] { get set }
    /// convex layers (凸型)
    var convexLayers: [CALayer] { get set }
}

extension NeumorphismCompatible {

    func synchronized<T>( _ action: () -> T) -> T {
        objc_sync_enter(self)
        let result = action()
        objc_sync_exit(self)
        return result
    }

    public var concaveLayers: [CALayer] {
        get {
            return synchronized {
                if let concaveLayersObject = objc_getAssociatedObject(self, &concaveLayersContext) as? [CALayer] {
                    return concaveLayersObject
                }
                let concaveLayersObject = [CALayer]()
                objc_setAssociatedObject(self, &concaveLayersContext, concaveLayersObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return concaveLayersObject
            }
        }
        set {
            synchronized {
                objc_setAssociatedObject(self, &concaveLayersContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    public var convexLayers: [CALayer] {
        get {
            return synchronized {
                if let convexLayersObject = objc_getAssociatedObject(self, &convexLayersContext) as? [CALayer] {
                    return convexLayersObject
                }
                let convexLayersObject = [CALayer]()
                objc_setAssociatedObject(self, &convexLayersContext, convexLayersObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return convexLayersObject
            }
        }
        set {
            synchronized {
                objc_setAssociatedObject(self, &convexLayersContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}

extension UIView: NeumorphismCompatible {}

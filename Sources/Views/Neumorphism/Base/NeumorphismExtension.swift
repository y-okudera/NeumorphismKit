//
//  NeumorphismExtension.swift
//  NeumorphismKit
//
//  Created by okudera on 2020/08/18.
//  Copyright © 2020 yuoku. All rights reserved.
//

public struct Extension<Base> {
    let base: Base
    init (_ base: Base) {
        self.base = base
    }
}

public protocol ExtensionCompatible {
    associatedtype Compatible
    static var nsk: Extension<Compatible>.Type { get }
    var nsk: Extension<Compatible> { get }
}

public extension ExtensionCompatible {
    static var nsk: Extension<Self>.Type {
        return Extension<Self>.self
    }

    var nsk: Extension<Self> {
        return Extension(self)
    }
}

//
//  Array+.swift
//  NeumorphismKit
//
//  Created by okudera on 2020/08/19.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

extension Array where Element: Equatable {

    subscript (safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
}

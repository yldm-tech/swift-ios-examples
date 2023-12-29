//
//  MAnchorKey.swift
//  Book3DAnimation
//
//  Created by Balaji on 19/07/23.
//

import SwiftUI

/// M - Matched Geometry Short Form
/// Used to Read View Bounds for our Custom Matched Geometry Effect
struct MAnchorKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
}

//
//  BookRotationHelper.swift
//  Book3DAnimation
//
//  Created by Balaji on 19/07/23.
//

import SwiftUI

/// Used for Book Flip Animation
struct BookRotationHelper: GeometryEffect {
    var rotation: CGFloat
    var animatableData: CGFloat {
        get { rotation }
        set {
            rotation = newValue
        }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        var transfrom = CATransform3DIdentity
        transfrom.m34 = 1 / 500
        transfrom = CATransform3DRotate(transfrom, deg2rad(rotation), 0, 1, 0)
        
        return .init(transfrom)
    }
    
    func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
}

//
//  CustomShape.swift
//  Wallet (iOS)
//
//  Created by Balaji on 01/05/21.
//

import SwiftUI

struct CustomShape: Shape {

    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

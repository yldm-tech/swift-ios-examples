//
//  CustomCorners.swift
//  Custom_Side_Menu (iOS)
//
//  Created by Balaji on 03/04/21.
//

import SwiftUI

// Custom Corner Shapes...
struct CustomCorners: Shape {

    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

//
//  CustomCorner.swift
//  Kids
//
//  Created by Balaji on 28/09/20.
//

import SwiftUI

struct CustomCorner : Shape {
    
    var corner : UIRectCorner
    var size : CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: size, height: size))
        
        return Path(path.cgPath)
    }
}

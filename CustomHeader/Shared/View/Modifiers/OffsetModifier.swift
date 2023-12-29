//
//  OffsetModifier.swift
//  OffsetModifier
//
//  Created by Balaji on 08/09/21.
//

import SwiftUI

// To get scroll Offset...
struct OffsetModifier: ViewModifier {
    
    @Binding var offset: CGFloat
    @State var startOffset: CGFloat = 0
    
    func body(content: Content) -> some View {
        
        content
            .overlay(
            
                GeometryReader{proxy in
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .global).minY)
                }
            )
            .onPreferenceChange(OffsetKey.self) { offset in
                if startOffset == 0{
                    startOffset = offset
                }
                self.offset = offset - startOffset
            }
    }
}

// Creating ScrollOffset Prefrence...
struct OffsetKey: PreferenceKey{
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

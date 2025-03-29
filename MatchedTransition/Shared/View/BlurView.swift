//
//  BlurView.swift
//  MatchedTransition (iOS)
//
//  Created by Balaji on 20/05/21.
//

import SwiftUI

struct BlurView: UIViewRepresentable {

    var effect: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: effect))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

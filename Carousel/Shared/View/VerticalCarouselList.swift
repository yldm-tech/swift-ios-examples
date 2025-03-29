//
//  VerticalCarouselList.swift
//  Carousel (iOS)
//
//  Created by Balaji on 10/07/21.
//

import SwiftUI

// Custom View Builder...
struct VerticalCarouselList<Content: View>: UIViewRepresentable {
    
    var content: Content
    
    init(@ViewBuilder content: @escaping ()->Content){
        self.content = content()
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        
        let scrollView = UIScrollView()
        setUp(scrollView: scrollView)
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
    
    func setUp(scrollView: UIScrollView){
     
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        
        // Extracting SwiftUI View....
        let hostView = UIHostingController(rootView: content)
        // Clearing BG Color of UIIVew...
        hostView.view.backgroundColor = .clear
        
        // COnstraints....
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
        
            hostView.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            // Width...
            hostView.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ]
        
        scrollView.addSubview(hostView.view)
        scrollView.addConstraints(constraints)
    }
}

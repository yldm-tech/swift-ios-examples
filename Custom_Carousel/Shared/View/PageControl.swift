//
//  PageControl.swift
//  Custom_Carousel (iOS)
//
//  Created by Balaji on 23/04/21.
//

import SwiftUI

struct PageControl: UIViewRepresentable {

    var maxPages: Int
    var currentPage: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        
        let control = UIPageControl()
        control.backgroundStyle = .minimal
        control.numberOfPages = maxPages
        control.currentPage = currentPage
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        
        // updating current Page...
        uiView.currentPage = currentPage
    }
}

//
//  WebView.swift
//  Marvel API
//
//  Created by Balaji on 14/03/21.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        
        let view = WKWebView()
        view.load(URLRequest(url: url))
        
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        
    }
}

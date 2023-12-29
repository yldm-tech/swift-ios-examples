//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 15/06/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
   
        // Since WIndow is Decrepted in iOS 15....
        // Getting Safe area using Geometry Reader...
        GeometryReader{proxy in
            
            let topEdge = proxy.safeAreaInsets.top
            
            Home(topEdge: topEdge)
                .ignoresSafeArea(.all, edges: .top)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

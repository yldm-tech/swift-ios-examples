//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 07/08/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        GeometryReader{proxy in
            
            let size = proxy.size
            let bottomEdge = proxy.safeAreaInsets.bottom
            
            Home(size: size,bottomEdge: bottomEdge)
                .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

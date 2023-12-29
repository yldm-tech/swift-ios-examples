//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 12/08/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        // For Safe Area Bottom...
        GeometryReader{proxy in
            
            let bottomEdge = proxy.safeAreaInsets.bottom
            
            Home(bottomEdge: (bottomEdge == 0 ? 15 : bottomEdge))
                .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

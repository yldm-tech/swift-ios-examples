//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 26/07/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

       // To Ignore and get Safe Area size...
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

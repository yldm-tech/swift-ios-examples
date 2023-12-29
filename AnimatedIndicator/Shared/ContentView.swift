//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 05/08/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        // Getting ScreenSize Globally...
        GeometryReader{proxy in
            
            let size = proxy.size
            
            Home(screenSize: size)
                .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

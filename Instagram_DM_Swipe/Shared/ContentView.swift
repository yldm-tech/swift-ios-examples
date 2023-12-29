//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 06/02/21.
//

import SwiftUI

struct ContentView: View {
    
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {

        NavigationView{
     
            GeometryReader{proxy in

                MainView(edges: proxy.safeAreaInsets)
                    .ignoresSafeArea()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

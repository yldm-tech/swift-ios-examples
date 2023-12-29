//
//  ContentView.swift
//  ToolBarAnimation
//
//  Created by Balaji on 01/08/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            Home()
                .navigationTitle("Toolbar Animation")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

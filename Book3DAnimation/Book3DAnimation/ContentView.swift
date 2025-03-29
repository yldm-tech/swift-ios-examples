//
//  ContentView.swift
//  Book3DAnimation
//
//  Created by Balaji Venkatesh on 27/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .preferredColorScheme(.light)
                .navigationTitle("Airbnb")
        }
    }
}

#Preview {
    ContentView()
}

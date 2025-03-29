//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 27/05/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        Home()
            .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

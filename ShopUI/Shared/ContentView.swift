//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 14/09/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        BaseView()
            .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

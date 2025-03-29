//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 19/09/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {

        ScrollView(UIScreen.main.bounds.height < 750 ? .vertical : .init(), showsIndicators: false) {
            
            Home()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
        .background(Color("BG"))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

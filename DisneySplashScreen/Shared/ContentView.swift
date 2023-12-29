//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 15/08/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        // Your Base View....
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Image("justine")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 480)
                        .cornerRadius(15)
                    
                    Text("iJustine")
                        .font(.title.bold())
                }
                .padding()
            }
            .navigationTitle("Latest")
        }
        // Use Overlay since ZStack having issues with animation...
        .overlay(SplashScreen())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

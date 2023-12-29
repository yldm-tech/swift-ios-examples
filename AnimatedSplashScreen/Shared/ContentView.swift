//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 25/06/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        SplashScreen(imageSize: CGSize(width: 128, height: 128)) {
            
            // Home View....

            Home()
            
        } titleView: {
            
            Text("Chatty")
                .font(.system(size: 35).bold())
                .foregroundColor(.white)
            
        } logoView: {
            
            // make sure to give exact size of logo frame here...
            // My eg has 128X128...
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
        } navButtons: {
            
            // Your Nav Bar Buttons...
            Button {
                
            } label: {
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
            }

        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

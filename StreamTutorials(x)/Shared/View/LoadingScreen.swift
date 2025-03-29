//
//  LoadingScreen.swift
//  Stream Tutorials
//
//  Created by Balaji on 23/03/21.
//

import SwiftUI

struct LoadingScreen: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        ZStack{
            
            Color.primary
                .opacity(0.2)
                .ignoresSafeArea()
            
            ProgressView()
                .frame(width: 50, height: 50)
                .background(colorScheme == .dark ? Color.black : Color.white)
                .cornerRadius(8)
        }
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}

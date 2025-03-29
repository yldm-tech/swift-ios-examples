//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 26/03/21.
//

import SwiftUI

struct ContentView: View {
    
    // ANimation Namespace...
    @Namespace var animation
    
    // StateObject...
    @StateObject var profileData = ProfileDetailModel()
    
    var body: some View {

        Home(animation: animation)
        // setting Environment Object...
            .environmentObject(profileData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

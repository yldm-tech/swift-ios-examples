//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 30/03/21.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_Status") var status = false
    var body: some View {

        // Chainging to home when user logged in...
        
        if status{
            Home()
        }
        else{
            Login()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

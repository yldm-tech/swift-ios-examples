//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 01/09/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @AppStorage("log_Status") var log_Status = false
    @State var skip = false
    var body: some View {

        if log_Status || skip{
            
            NavigationView{
                
                Button("Signout"){
                    withAnimation{
                        log_Status = false
                    }
                    try! Auth.auth().signOut()
                }
                .navigationTitle("Home")
            }
        }
        else{
            Login(skip: $skip)
                .preferredColorScheme(.light)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

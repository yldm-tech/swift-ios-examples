//
//  BlogApp.swift
//  Shared
//
//  Created by Balaji on 10/08/21.
//

import SwiftUI
import Firebase

@main
struct BlogApp: App {
    
    // Intailzing Firebase...
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

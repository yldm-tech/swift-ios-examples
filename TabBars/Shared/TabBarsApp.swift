//
//  TabBarsApp.swift
//  Shared
//
//  Created by Balaji on 20/01/21.
//

import SwiftUI

@main
struct TabBarsApp: App {
    var body: some Scene {
        
        // Hiding Window For Only MacOS...
        #if os(iOS)
        WindowGroup {
            ContentView()
        }
        #else
        WindowGroup {
            ContentView()
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        #endif
    }
}

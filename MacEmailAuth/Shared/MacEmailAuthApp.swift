//
//  MacEmailAuthApp.swift
//  Shared
//
//  Created by Balaji on 30/03/21.
//

import SwiftUI
import Firebase

@main
struct MacEmailAuthApp: App {
    // COnnecting...
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // hiding window...
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

// App delegate...

class AppDelegate: NSObject,NSApplicationDelegate{
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        // Intializing Firebase...
        FirebaseApp.configure()
    }
}

// To Hide Foucs Ring on textfield...
extension NSTextField{
    open override var focusRingType: NSFocusRingType{
        get{.none}
        set{}
    }
}

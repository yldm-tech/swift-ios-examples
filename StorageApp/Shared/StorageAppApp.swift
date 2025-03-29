//
//  StorageAppApp.swift
//  Shared
//
//  Created by Balaji on 06/06/21.
//

import SwiftUI

@main
struct StorageAppApp: App {
    var body: some Scene {
        #if os(macOS)
        WindowGroup {
            ContentView()
        }
        // Hiding Title Bar...
        .windowStyle(HiddenTitleBarWindowStyle())
        #else
        WindowGroup {
            ContentView()
        }
        #endif
    }
}

#if os(macOS)
// Hiding Focus Ring...
extension NSTextField{
    open override var focusRingType: NSFocusRingType{
        get{.none}
        set{}
    }
}
#endif

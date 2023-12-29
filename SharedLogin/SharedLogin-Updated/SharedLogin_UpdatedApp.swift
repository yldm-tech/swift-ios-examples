//
//  SharedLogin_UpdatedApp.swift
//  SharedLogin-Updated
//
//  Created by Balaji on 16/03/23.
//

import SwiftUI

@main
struct SharedLogin_UpdatedApp: App {
    var body: some Scene {
        /// Hiding Title Bar For Only macOS
        #if os(iOS)
        WindowGroup {
            ContentView()
        }
        #else
        WindowGroup {
            ContentView()
        }
        .windowStyle(.hiddenTitleBar)
        #endif
    }
}

/// Disabling macOS Focus Ring
#if !os(iOS)
extension NSTextField{
    open override var focusRingType: NSFocusRingType{
        get{.none}
        set{}
    }
}
#endif

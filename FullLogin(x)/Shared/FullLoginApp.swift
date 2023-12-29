//
//  FullLoginApp.swift
//  Shared
//
//  Created by Balaji on 01/09/21.
//

import SwiftUI
import Firebase

@main
struct FullLoginApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// Intialzing Firebase...
class AppDelegate: NSObject,UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Intialize Firebase...
        FirebaseApp.configure()
        return true
    }
    
    // For OTP vertification...
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
    }
}

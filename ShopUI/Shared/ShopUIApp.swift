//
//  ShopUIApp.swift
//  Shared
//
//  Created by Balaji on 14/09/21.
//

import SwiftUI

@main
struct ShopUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension View{
    
    func getRect()->CGRect{
        UIScreen.main.bounds
    }
    
    func getSafeArea()->UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }
        
        return safeArea
    }
}

//
//  LoginViewModel.swift
//  SharedLogin (iOS)
//
//  Created by Balaji on 11/01/21.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    /// View Properties
    @Published var email = ""
    @Published var password = ""
    @Published var reEnter = ""
    @Published var gotoRegister = false
    @Published var ismacOS = false
    
    /// Screen Size
    var screen: CGRect {
        #if os(iOS)
        return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.screen.bounds ?? .zero
        #else
        
        return NSScreen.main?.visibleFrame ?? .zero
        #endif
    }
    
    init() {
        #if !os(iOS)
        self.ismacOS = true
        #endif
    }
    
    /// Clearing Data When Going to Login / Register Page
    func clearData() {
        email = ""
        password = ""
        reEnter = ""
    }
}

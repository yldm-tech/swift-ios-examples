//
//  BottomBarViewModel.swift
//  SafariTabBar (iOS)
//
//  Created by Balaji on 20/06/21.
//

import SwiftUI

class BottomBarViewModel: ObservableObject {
    
    // All Properties....
    @Published var searchText = "iJustine"
    // Offset...
    @Published var offset: CGFloat = 0
    @Published var lastStoredOffset: CGFloat = 0
    @Published var tabState : BottomState = .floating
}

// Enum For State...
enum BottomState{
    case floating
    case expanded
}

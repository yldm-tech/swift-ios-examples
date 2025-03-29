//
//  TabViewModel.swift
//  TabViewModel
//
//  Created by Balaji on 19/07/21.
//

import SwiftUI

class TabViewModel: ObservableObject {
    
    @Published var currentTab = "Home"
    
    // Detail Data...
    @Published var currentCard: Card?
    @Published var showDetail: Bool = false
}

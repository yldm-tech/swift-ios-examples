//
//  MenuModel.swift
//  Drawer (iOS)
//
//  Created by Balaji on 30/01/21.
//

import SwiftUI

// Menu Data...

class MenuViewModel: ObservableObject{
    
    //Default...
    @Published var selectedMenu = "Catalogue"
    
    // Show...
    @Published var showDrawer = false
}

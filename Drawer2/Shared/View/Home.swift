//
//  Home.swift
//  Drawer (iOS)
//
//  Created by Balaji on 30/01/21.
//

import SwiftUI

struct Home: View {
    
    // Hiding tab Bar...
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @StateObject var menuData = MenuViewModel()
    
    @Namespace var animation
    
    var body: some View {
        
        HStack(spacing: 0){
            // Drawer And Main View...
            
            // Drawer...
            Drawer(animation: animation)
            
            // Main View...
            
            TabView(selection: $menuData.selectedMenu){
                
                Catalogue()
                    .tag("Catalogue")
                
                Orders()
                    .tag("Your Orders")
                
                Cart()
                    .tag("Your Cart")
                
                Favourites()
                    .tag("Favourites")
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        // Max Frame...
        .frame(width: UIScreen.main.bounds.width)
        // Moving View....
        // 250/2 => 125....
        .offset(x: menuData.showDrawer ? 125 : -125)
        .overlay(
        
            ZStack{
                
                if !menuData.showDrawer{
                    
                    DrawerCloseButton(animation: animation)
                        .padding()
                }
            },
            alignment: .topLeading
        )
        
        // Setting As Environment Object....
        // For Avoiding Re-Declarations...
        .environmentObject(menuData)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

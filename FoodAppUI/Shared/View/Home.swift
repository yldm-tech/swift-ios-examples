//
//  Home.swift
//  Food App UI (iOS)
//
//  Created by Balaji on 08/04/21.
//

import SwiftUI

struct Home: View {
    
    // Hiding Tab Bar..
    init() {
        UITabBar.appearance().isHidden = true
    }
    // selected Category...
    @State var selectedCategory : Category = categories.first!
    @State var selectedTab: String = "home"
    
    var body: some View {
        
        // Tab VIew...
        VStack(spacing: 0) {
            
            TabView{
                
                LandingPage(selectedCategory: $selectedCategory)
                    .tag("home")
                
                Color.pink
                    .tag("heart")
                
                Color.yellow
                    .tag("bell")
                
                Color.red
                    .tag("cart")
            }
            
            // Custom Tab Bar....
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea()
        .preferredColorScheme(.light)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// Extending View To Get Screen Frame...
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}

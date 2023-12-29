//
//  MainView.swift
//  Instagram_DM_Swipe (iOS)
//
//  Created by Balaji on 06/02/21.
//

import SwiftUI

// See Scrollable Tab Bar Video...
// Link IN Description...

struct MainView: View {
    
    @State var selectedTab = "house.fill"
    var edges: EdgeInsets
    
    @State var tabBarOffset: CGFloat = 0
    
    var body: some View {
        
        // Scrollable Tabs....
        
        TabView(selection: $selectedTab){
            
            Home(edges: edges, selectedTab: $selectedTab)
                .ignoresSafeArea()
                .tag("house.fill")
            
            Text("Search")
                .tag("magnifyingglass")
            
            Text("Reels")
                .tag("airplayvideo")
            
            Text("Liked")
                .tag("suit.heart.fill")
            
            Text("Account")
                .tag("person.circle")
        }
        .tabViewStyle(DefaultTabViewStyle())
        .overlay(
        
            // Custom Tab Bar...
            
            ZStack{
            
            if selectedTab != "house.fill"{CustomTabBar(selectedTab: $selectedTab, edges: edges)}
            
            }
            
            ,alignment: .bottom
        )
        .ignoresSafeArea(.all, edges: .bottom)
        .navigationBarHidden(true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomTabBar: View{
    
    @Binding var selectedTab: String
    var edges: EdgeInsets
    @Environment(\.colorScheme) var scheme
    
    var body: some View{
        
        VStack(spacing: 12){
            
            Divider()
                .padding(.horizontal,-15)
            
            HStack(spacing: 0){
                
                TabBarButton(image: "house.fill", selectedTab: $selectedTab)
                    .frame(maxWidth: .infinity)
                
                TabBarButton(image: "magnifyingglass", selectedTab: $selectedTab)
                    .frame(maxWidth: .infinity)
                
                TabBarButton(image: "airplayvideo", selectedTab: $selectedTab)
                    .frame(maxWidth: .infinity)
                
                TabBarButton(image: "suit.heart.fill", selectedTab: $selectedTab)
                    .frame(maxWidth: .infinity)
                
                TabBarButton(image: "person.circle", selectedTab: $selectedTab)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal)
        .padding(.bottom,15)
        .padding(.bottom,edges.bottom)
        .background(scheme == .dark ? Color.black : Color.white)
    }
}

// Tab Bar Button...

struct TabBarButton: View {
    
    var image: String
    @Binding var selectedTab: String
    
    var body: some View{
    
        Button(action: {
            selectedTab = image
        }, label: {
            Image(systemName: image)
                .font(.title2)
                .foregroundColor(selectedTab == image ? .primary : .gray)
        })
    }
}


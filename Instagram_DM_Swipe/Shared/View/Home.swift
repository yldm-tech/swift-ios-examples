//
//  Home.swift
//  Instagram_DM_Swipe (iOS)
//
//  Created by Balaji on 06/02/21.
//

import SwiftUI

struct Home: View {
    
    @State var currentTab = "Home"
    
    // To Update For Dark Mode...
    @Environment(\.colorScheme) var scheme
    
    var edges: EdgeInsets
    
    @Binding var selectedTab: String
    
    var body: some View {
        
        // Instagram Home View...
        
        ScrollView(.init()){
            
            TabView(selection: $currentTab){
                
                PostView(currentTab: $currentTab, edges: edges)
                    .ignoresSafeArea()
                    .tag("Post")
                
                FeedView(currentTab: $currentTab, edges: edges)
                    .tag("Home")
                    .overlay(
                        
                        // Custom Tab Bar Only Feed View...
                        
                        ZStack{
                        
                        if selectedTab == "house.fill"{CustomTabBar(selectedTab: $selectedTab, edges: edges)}
                        
                        }
                        
                        ,alignment: .bottom
                    )
                    .ignoresSafeArea(.all, edges: .bottom)
                
                DirectView(currentTab: $currentTab, edges: edges)
                    .tag("Direct")
                    .ignoresSafeArea()
                    
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .navigationBarHidden(true)
        .animation(.easeOut, value: currentTab)
    }
}

struct OffsetModifier: ViewModifier{
    
    @Binding var offset: CGFloat
    
    func body(content: Content) -> some View {
        
        content
            .overlay(
            
                GeometryReader{proxy -> Color in
                
                let minX = proxy.frame(in: .global).minX
                
                DispatchQueue.main.async {
                
                    offset = minX
                }
                
                return Color.clear
                }
            )
    }
}

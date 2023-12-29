//
//  Home.swift
//  Reels (iOS)
//
//  Created by Balaji on 29/06/21.
//

import SwiftUI

struct Home: View {
    // Hiding Tab Bar...
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    @State var currentTab = "Reels"
    
    var body: some View {
        
        // Custom Tab VIew...
        VStack(spacing: 0){
            TabView(selection: $currentTab){
                
                Text("Home")
                    .tag("house.fill")
                
                Text("Search")
                    .tag("magnifyingglass")
                
                // Reels View...
                ReelsView()
                    .tag("Reels")
                
                Text("Liked")
                    .tag("suit.heart")
                
                Text("Profile")
                    .tag("person.circle")
            }
            
            HStack(spacing: 0){
                
                // simply creating array of images....
                ForEach(["house.fill","magnifyingglass","Reels","suit.heart","person.circle"],id: \.self){image in
                    
                    TabBarButton(image: image, isSystemImage: image != "Reels", currentTab: $currentTab)
                }
            }
            .padding(.horizontal)
            .padding(.vertical,10)
            .overlay(Divider(),alignment: .top)
            // if reels changing color to black...
            .background(currentTab == "Reels" ? .black : .clear)
            // In iOS 15 it will automatically fill safe area....
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// Tab Bar Button....
struct TabBarButton: View{
    
    var image: String
    var isSystemImage: Bool
    @Binding var currentTab: String
    
    var body: some View{
        
        Button {
            withAnimation{currentTab = image}
        } label: {
            
            ZStack{
                if isSystemImage{
                    Image(systemName: image)
                        .font(.title2)
                }
                else{
                    Image(image)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                }
            }
            .foregroundColor(currentTab == image ? currentTab == "Reels" ? .white : .primary : .gray)
            .frame(maxWidth: .infinity)
        }

    }
}

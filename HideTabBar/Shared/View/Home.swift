//
//  Home.swift
//  Home
//
//  Created by Balaji on 13/08/21.
//

import SwiftUI

struct Home: View {
    
    // Current Tab...
    @State var currentTab = "Mail"
    
    var bottomEdge: CGFloat
    
    // Hiding Native TabBar...
    init(bottomEdge: CGFloat){
        UITabBar.appearance().isHidden = true
        self.bottomEdge = bottomEdge
    }
    
    @State var hideBar = false
    
    var body: some View {
        
        // Tab VIew...
        TabView(selection: $currentTab) {
            
            MailView(hideTab: $hideBar, bottomEdge: bottomEdge)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.primary.opacity(0.05))
                .tag("Mail")
            
            Text("Meet")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.primary.opacity(0.05))
                .tag("Meet")
        }
        .overlay(
        
            VStack{
                
                // FAB Button...
                Button {
                } label: {
                    
                    HStack(spacing: hideBar ? 0 : 12){
                        
                        Image(systemName: "pencil")
                            .font(.title)
                        
                        Text("Compose")
                            .fontWeight(.semibold)
                            .frame(width: hideBar ? 0 : nil, height: hideBar ? 0 : nil)
                    }
                    .foregroundColor(Color("Pink"))
                    .padding(.vertical,hideBar ? 15 : 12)
                    .padding(.horizontal)
                    .background(Color("TabBG"),in: Capsule())
                    .shadow(color: .primary.opacity(0.06), radius: 5, x: 5, y: 10)
                }
                .padding(.trailing)
                .offset(y: -15)
                .frame(maxWidth: .infinity , alignment: .trailing)
                .opacity(currentTab == "Mail" ? 1 : 0)
                // No Animation...
                .animation(.none, value: currentTab)

                
                // Custom Tab Bar...
                CustomTabBar(currentTab: $currentTab,bottomEdge: bottomEdge)
            }
            // Hiding Tab Bar when scrolled....
            // Top Padding  = 15,
            // Image Size = 35
            // BOttom Edge...
                .offset(y: hideBar ? (15 + 35 + bottomEdge) : 0)
            
            ,alignment: .bottom
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

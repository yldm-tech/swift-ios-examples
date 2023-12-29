//
//  CustomTabBar.swift
//  CustomTabBar
//
//  Created by Balaji on 13/08/21.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var currentTab: String
    var bottomEdge: CGFloat
    var body: some View {
        
        HStack(spacing: 0){
            
            // Tab BUtton...
            // FOreach Method...
            ForEach(["Mail","Meet"],id: \.self){image in
                
                TabButton(image: image, currentTab: $currentTab,badge: image == "Mail" ? 99 : 0)
            }
        }
        .padding(.top,15)
        .padding(.bottom,bottomEdge)
        .background(Color("TabBG"))
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}

struct TabButton: View{
    
    var image: String
    @Binding var currentTab: String
    
    // Optional Badge...
    var badge: Int = 0
    
    // Based On Color SCheme changing Color...
    @Environment(\.colorScheme) var scheme
    
    var body: some View{
        
        Button {
            
            withAnimation{currentTab = image}
            
        } label: {
            
            Image(image)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35, height: 35)
                .foregroundColor(currentTab == image ? Color("Pink") : Color.gray.opacity(0.7))
                .overlay(
                
                    Text("\(badge < 100 ? badge : 99)+")
                        .font(.caption.bold())
                        .foregroundColor(scheme == .dark ? .black : .white)
                        .padding(.vertical,4)
                        .padding(.horizontal,5)
                        .background(Color("Pink"),in: Capsule())
                        .background(
                        
                            Capsule()
                                .stroke(scheme == .dark ? .black : .white,lineWidth: 4)
                        )
                        .offset(x: 20, y: -5)
                        .opacity(badge == 0 ? 0 : 1)
                    
                    ,alignment: .topTrailing
                )
                .frame(maxWidth: .infinity)
        }

    }
}

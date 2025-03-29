//
//  Home.swift
//  AnimatedSplashScreen (iOS)
//
//  Created by Balaji on 26/06/21.
//

import SwiftUI

struct Home: View {
    @State var currentTab = "All Photos"
    @Namespace var animation
    
    var body: some View {
        
        VStack(spacing: 0){
            
            // Tab Bar...
            HStack(spacing: 0){
                
                TabButton(title: "All Photos", animation: animation, currentTab: $currentTab)
                
                TabButton(title: "Chats", animation: animation, currentTab: $currentTab)
                
                TabButton(title: "Status", animation: animation, currentTab: $currentTab)
            }
            .padding(.top,20)
            .background(Color("Purple"))
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 15){
                    
                    ForEach(1...6,id: \.self){index in
                        
                        Image("post\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width - 30, height: 250)
                            .cornerRadius(8)
                    }
                }
                .padding(15)
            }
        }
        .background(.quaternary)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// Tab Bar Button...
struct TabButton: View{
    var title: String
    var animation: Namespace.ID
    @Binding var currentTab: String
    
    var body: some View{
        
        Button {
            withAnimation(.spring()){
                currentTab = title
            }
        } label: {
            
            VStack{
                
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
               
                // Slider...
                ZStack{
                    
                    if currentTab == title{
                        Capsule()
                            .fill(.white)
                        // Shadow...
                            .shadow(radius: 15)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                            .frame(height: 3.5)
                    }
                    else{
                        Capsule()
                            .fill(.clear)
                            .frame(height: 3.5)
                    }
                }
            }
        }

    }
}

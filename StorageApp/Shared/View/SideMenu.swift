//
//  SideMenu.swift
//  StorageApp (iOS)
//
//  Created by Balaji on 06/06/21.
//

import SwiftUI

struct SideMenu: View {
    @Binding var currentTab: String
    @Namespace var animation
    var body: some View {
        
        VStack{
            
            HStack{
                
                Text("Files")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    // Letter Spacing...
                    .kerning(1.5)
                
                Text("Go")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .kerning(1.5)
                    .padding(8)
                    .background(Color("blue"))
                    .cornerRadius(8)
            }
            .padding(10)
            
            Divider()
                .background(Color.gray.opacity(0.4))
                .padding(.bottom)
            
            HStack(spacing: 12){
                
                Image("pic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                Text("Hi, iJustine")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
            
            VStack(spacing: 15){
                
                TabButton(image: "house.fill", title: "Home", animation: animation, currentTab: $currentTab)
                
                TabButton(image: "folder.fill.badge.person.crop", title: "Shared Files", animation: animation, currentTab: $currentTab)
                
                TabButton(image: "star", title: "Starred Files", animation: animation, currentTab: $currentTab)
                
                TabButton(image: "waveform.path.ecg.rectangle.fill", title: "Statistics", animation: animation, currentTab: $currentTab)
                
                TabButton(image: "gearshape", title: "Settings", animation: animation, currentTab: $currentTab)
                
                TabButton(image: "rectangle.righthalf.inset.fill.arrow.right", title: "Log Out", animation: animation, currentTab: .constant(""))
            }
            .padding(.leading,20)
            .offset(x: 15)
            .padding(.top,20)
        }
        // To Avoid Spacers...
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Tab Button....
struct TabButton: View {
    
    var image: String
    var title: String
    var animation: Namespace.ID
    @Binding var currentTab: String
    
    var body: some View{
        
        Button(action: {
            withAnimation{
                currentTab = title
            }
        }, label: {
            
            HStack(spacing: 15){
                
                Image(systemName: image)
                    .font(.title2)
                    .foregroundColor(currentTab == title ? Color("blue") : Color.gray.opacity(0.8))
                
                Text(title)
                    .foregroundColor(Color.black.opacity(0.8))
                    .kerning(1.2)
            }
            .padding(.vertical,12)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
            
                ZStack{
                    
                    if currentTab == title{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                        // For Sliding Effect...
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                    else{
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.clear)
                    }
                }
            )
            // For Mouse Clicking on Padded Areas...
            .contentShape(Rectangle())
        })
    }
}

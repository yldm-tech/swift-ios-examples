//
//  Home.swift
//  Home
//
//  Created by Balaji on 29/07/21.
//

import SwiftUI

struct Home: View {
    
    @StateObject var storyData = StoryViewModel()
    
    var body: some View {
       
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false) {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    // Showing User Stories...
                    HStack(spacing: 12){
                        
                        Button {
                            
                        } label: {
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay(
                                
                                    Image(systemName: "plus")
                                        .padding(7)
                                        .background(.blue,in: Circle())
                                        .foregroundColor(.white)
                                        .padding(2)
                                        .background(.black,in: Circle())
                                        .offset(x: 10, y: 10)
                                    
                                    ,alignment: .bottomTrailing
                                )
                        }
                        .padding(.trailing,10)
                        
                        // Stories...
                        ForEach($storyData.stories){$bundle in
                            
                            // ProfileView...
                            // In iOS 15 we can directly pass Bindings from forEach...
                            
                            ProfileView(bundle: $bundle)
                                .environmentObject(storyData)
                        }

                    }
                    .padding()
                    .padding(.top,10)
                }
            }
            .navigationTitle("Instagram")
        }
        .overlay(
        
            StoryView()
                .environmentObject(storyData)
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct ProfileView: View{
    
    @Binding var bundle: StoryBundle
    
    @Environment(\.colorScheme) var scheme
    
    @EnvironmentObject var storyData: StoryViewModel
    
    var body: some View{
        
        Image(bundle.profileImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 50, height: 50)
            .clipShape(Circle())
        // Progress Ring showing only is not seen...
            .padding(2)
            .background(scheme == .dark ? .black : .white, in: Circle())
            .padding(3)
            .background(
            
                LinearGradient(colors: [
                
                    .red,
                    .orange,
                    .red,
                    .orange
                ],
                startPoint: .top,
                endPoint: .bottom)
                .clipShape(Circle())
                .opacity(bundle.isSeen ? 0 : 1)
            )
            .onTapGesture {
                
                withAnimation{
                    bundle.isSeen = true
                    
                    // Saving current Bundle and toggling story...
                    storyData.currentStory = bundle.id
                    storyData.showStory = true
                }
            }
    }
}

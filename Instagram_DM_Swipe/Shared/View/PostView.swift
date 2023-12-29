//
//  PostView.swift
//  Instagram_DM_Swipe (iOS)
//
//  Created by Balaji on 06/02/21.
//

import SwiftUI

struct PostView: View {
    @Binding var currentTab: String
    var edges: EdgeInsets
    var body: some View {
        
        ZStack{
            
            // Camera View...
            // Will Be Implemented Later...
            
            Color.black
                .ignoresSafeArea()
            
            CameraView(currentTab: $currentTab, edges: edges)
            
            VStack{
                
                HStack{
                    
                    Button(action: {}, label: {
                        Image(systemName: "gear")
                            .font(.title)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        currentTab = "Home"
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.title)
                    })
                }
                .foregroundColor(.white)
                .padding()
                
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "photo")
                        .font(.title)
                })
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .padding(.top,edges.top)
            .padding(.bottom,edges.bottom)
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  Home.swift
//  WhatsApp Hero Animation (iOS)
//
//  Created by Balaji on 27/03/21.
//

import SwiftUI

struct Home: View {
    
    var animation: Namespace.ID
    @EnvironmentObject var profileData: ProfileDetailModel
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false, content: {
            
            VStack(alignment: .leading, spacing: 15, content: {
                
                Text("WhatsApp")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.top)
                
                ForEach(recents){recent in
                    
                    // Recent Row View....
                    RecentRowView(recent: recent,animation: animation)
                }
            })
        })
        .overlay(
        
            ZStack{
                
                if profileData.showProfile{
                    ProfileDetailView(animation: animation)
                }
            }
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

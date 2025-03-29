//
//  TabBar.swift
//  App Store
//
//  Created by Balaji on 14/11/20.
//

import SwiftUI

struct TabBar: View {
    @Namespace var animation
    @StateObject var detailObject = DetailViewModel()
    
    var body: some View {
        
        ZStack{
            

            TabView{
                
                Today(animation: animation)
                    .environmentObject(detailObject)
                    .tabItem{
                        
                        Image("today")
                            .renderingMode(.template)
                        
                        Text("Today")
                    }
                
                Text("Games")
                    .tabItem{
                        
                        Image("games")
                            .renderingMode(.template)
                        
                        Text("Games")
                    }
                
                Text("Apps")
                    .tabItem{
                        
                        Image("apps")
                            .renderingMode(.template)
                        
                        Text("Apps")
                    }
                
                Text("Search")
                    .tabItem{
                        
                        Image("search")
                            .renderingMode(.template)
                        
                        Text("Search")
                    }
            }
            .opacity(detailObject.show ? 0 : 1)
            
            // hiding tab bar when detail page opnes...
            //.opacity(detailObject.show ? 0 : 1)
            
            if detailObject.show{
                
                Detail(detail: detailObject, animation: animation)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

//
//  Home.swift
//  Marvel API
//
//  Created by Balaji on 14/03/21.
//

import SwiftUI

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    var body: some View {
        
        TabView{
            
            // Characters View...
            CharactersView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Chracters")
                }
            // setting Environment Object...
            // so that we can access data on character View...
                .environmentObject(homeData)
            
            ComicsView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Comics")
                }
                .environmentObject(homeData)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

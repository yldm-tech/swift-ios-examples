//
//  Home.swift
//  Home
//
//  Created by Balaji on 26/08/21.
//

import SwiftUI

struct Home: View {
    
    // Currenttab...
    @State var currentSelection: Int = 0
    
    var body: some View {
        
        NavigationView{
            
            PagerTabView(tint: .black,selection: $currentSelection){
                
                Image(systemName: "house.fill")
                    .pageLabel()
                
                Image(systemName: "magnifyingglass")
                    .pageLabel()
                
                Image(systemName: "person.fill")
                    .pageLabel()
                
                Image(systemName: "gearshape")
                    .pageLabel()
                
            } content: {
                
                ZStack{
                    Color.red
                    
                    NavigationLink("Click Me") {
                        Text("Detail")
                    }
                }
                .pageView(ignoresSafeArea: true, edges: .bottom)
                
                ZStack{
                    Color.green
                    
                    NavigationLink("Click Me") {
                        Text("Detail")
                    }
                }
                .pageView(ignoresSafeArea: true, edges: .bottom)
                
                Color.yellow
                    .pageView(ignoresSafeArea: true, edges: .bottom)
                
                Color.purple
                    .pageView(ignoresSafeArea: true, edges: .bottom)
            }
            .padding(.top)
            .ignoresSafeArea(.container, edges: .bottom)
            .navigationTitle("Pager")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

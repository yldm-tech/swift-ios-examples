//
//  Home.swift
//  Home
//
//  Created by Balaji on 06/09/21.
//

import SwiftUI

struct Home: View {
    @Binding var showMenu: Bool
    var body: some View {
        
        VStack{
            
            VStack(spacing: 0){
                
                HStack{
                    
                    Button {
                        withAnimation{showMenu.toggle()}
                    } label: {
                        Image("Pic")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    // Navigation Link...
                    NavigationLink {
                        
                        Text("Timeline View")
                            .navigationTitle("Timeline")
                        
                    } label: {
                        
                        Image("Sparkles")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(.primary)
                    }

                }
                .padding(.horizontal)
                .padding(.vertical,10)
                
                Divider()
            }
            .overlay(
            
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
            )
            
            Spacer()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

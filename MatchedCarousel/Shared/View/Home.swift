//
//  Home.swift
//  MatchedCarousel (iOS)
//
//  Created by Balaji on 23/06/21.
//

import SwiftUI

struct Home: View {
    // Background will be current tab image....
    @State var currentTab = "p1"
    var body: some View {
        
        ZStack{
            
            // Geometry Reader for getting Screen Size..
            GeometryReader{proxy in
                let size = proxy.size
                
                Image(currentTab)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(1)
            }
            .ignoresSafeArea()
            // Material Effect...
            .overlay(.ultraThinMaterial)
            // Dark Effect...
            .colorScheme(.dark)
            
            // Carousel List...
            TabView(selection: $currentTab){
                
                // Since were having 7 images....
                ForEach(1...7,id: \.self){index in
                    
                    // CarouselBody View....
                    CarouselBodyView(index: index)
                }
            }
            // Page tab style...
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

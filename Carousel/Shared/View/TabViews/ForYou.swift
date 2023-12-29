//
//  ForYou.swift
//  Carousel (iOS)
//
//  Created by Balaji on 10/07/21.
//

import SwiftUI

struct ForYou: View {
    
    var topEdge: CGFloat
    
    var body: some View {
        
        VStack(spacing: 15){
            
            HStack{
                
                Text("Today For You")
                    .font(.title.bold())
                
                Spacer(minLength: 10)
                
                Button {
                    
                } label: {
                    
                    Image(systemName: "person.circle")
                        .font(.title)
                        .foregroundColor(.gray)
                        .overlay(
                        
                            Circle()
                                .fill(.red)
                                .frame(width: 13, height: 13)
                                .offset(x: -1, y: -1)
                            
                            ,alignment: .topTrailing
                        )
                }

            }
            .padding(.horizontal)
            // Setting MaxHeight for offset Calculation...
            .frame(height: 70)
            
            GeometryReader{proxy in
                
                let size = proxy.size
                
                // Custom Vertical Carousel List....
                VerticalCarouselList {
                    
                    VStack(spacing: 0){
                        
                        // Movies....
                        ForEach(movies){movie in
                            
                            // Card View...
                            // 70 = Title View...
                            // 15 = Spacing...
                            // Remaining is SafeArea top....
                            
                            MovieCardView(movie: movie,topOffset: 70 + 15 + topEdge)
                                .frame(height: size.height)
                        }
                    }
                }
            }
        }
    }
}

struct ForYou_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MovieCardView: View{
    
    var movie: Movie
    var topOffset: CGFloat
    
    var body: some View{
        
        // To get size for Image...
        // Using Geometry Reader....

        GeometryReader{proxy in
            
            let size = proxy.size
            
            // Scaling and Opactiy Effect.....
            let minY = proxy.frame(in: .global).minY - topOffset
            
            let progress = -minY / size.height
            
            // Increasing Scale by 3...
            let scale = 1 - (progress / 3)
            
            // Why this is Happening...
            // bcz we need to eleminate top offset...
            // to get started from 0.....
            
            // Opacity...
            let opacity = 1 - progress
            
            ZStack{
                
                Image(movie.artwork)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width - 30, height: size.height - 80)
                    .cornerRadius(15)
            }
            .padding(.horizontal,15)
            .scaleEffect(minY < 0 ? scale : 1)
            .opacity(minY < 0 ? opacity : 1)
            // stopping view when y value goes < 0....
            .offset(y: minY < 0 ? -minY : 0)
        }
    }
}

// Preview Bug.....

//
//  Home.swift
//  InfiniteCarousel (iOS)
//
//  Created by Balaji on 21/09/21.
//

import SwiftUI

struct Home: View {
    
    // Tabs...
    @State var tabs: [Tab] = [
    
        Tab(title: "4+ Years\nExercising"),
        Tab(title: "Fitness Underground"),
        Tab(title: "Intense Fitness"),
        Tab(title: "Power Fit Kids"),
        Tab(title: "Get Outdoors Fitness"),
    ]
    
    @State var currentIndex: Int = 0
    
    var body: some View {
        
        VStack(spacing: 0){
            
            HStack{
                
                Button {
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.body.bold())
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(
                        
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.white.opacity(0.6),lineWidth: 1)
                        )
                }

                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }

            }
            .overlay(
            
                // Custom Paging Indicator...
                HStack(spacing: 5){
                 
                    ForEach(tabs.indices,id: \.self){index in
                        Capsule()
                            .fill(Color.white.opacity(currentIndex == index ? 1 : 0.55))
                            .frame(width: currentIndex == index ? 18 : 4, height: 4)
                            .animation(.easeInOut, value: currentIndex)
                    }
                }
            )
            .padding()
            
            // ScrollView for adapting for small screens..
            ScrollView(getRect().height < 750 ? .vertical : .init(), showsIndicators: false) {
                
                VStack(spacing: 20){
                    
                    Text("Perpare Training")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white.opacity(0.6))
                        .padding(.top,20)
                    
                    Text("Let's create a\ntraining plan\nfor you!")
                        .font(.system(size: 38, weight: .bold))
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .foregroundColor(.white)
                    
                    // Carousel SLider....
   
                    InfiniteCarouselView(tabs: $tabs, currentIndex: $currentIndex)
                }
                .frame(maxWidth: .infinity, alignment: .top)
            }
            
            // Bottom Bar..
            
            HStack{
                
                Text("Next Step")
                    .font(.title3.bold())
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.body.bold())
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(
                        
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.white.opacity(0.3),lineWidth: 1)
                        )
                }
            }
            .padding(.top,25)
            .padding(.horizontal,30)
            .padding(.bottom,12)
            .background(
            
                Color.black
                    .clipShape(CustomCorner(corners: [.topLeft,.topRight], radius: 38))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
        
            // Gradient BG...
            LinearGradient(colors: [
            
                Color("BG1"),
                Color("BG2")
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// Extedning View to get Screen Bounds...
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}

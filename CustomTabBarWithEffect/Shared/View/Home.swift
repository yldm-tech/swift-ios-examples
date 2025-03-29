//
//  Home.swift
//  Home
//
//  Created by Balaji on 19/07/21.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var tabData: TabViewModel
    
    // For Animation...
    var animation: Namespace.ID
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 18){
                
                Text("Best Selling")
                    .font(.system(size: 35).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                // Cards.....
                
                ForEach(cards){card in
                    
                    Button {
                        
                        withAnimation(.spring()){
                            tabData.currentCard = card
                            tabData.showDetail = true
                        }
                        
                    } label: {
                        
                        // To avoid that Warning...
                        // You muse remove another one...
                        CardView(card: card)
                        .padding()
                        .background(
                        
                            cardBG(card: card)
                        )
                        .foregroundColor(.white)
                    }
                    .buttonStyle(CardButtonStyle())

                }
            }
            .padding()
            // Bottom Padding to show the content available on bottom....
            // Safe area edge is not working on TabView...
            // it's only working with scrollview....
            .padding(.bottom,80)
        }
    }
    
    @ViewBuilder
    func cardBG(card: Card)-> some View{
        
        ZStack{
            
            if tabData.showDetail && tabData.currentCard == card{
                LinearGradient(
                    colors: [
                    
                        Color("\(card.cardColor)1"),
                        Color("\(card.cardColor)2"),
                        Color("\(card.cardColor)3"),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
                    .cornerRadius(15)
                    .opacity(0)
            }
            else{
                LinearGradient(
                    colors: [
                    
                        Color("\(card.cardColor)1"),
                        Color("\(card.cardColor)2"),
                        Color("\(card.cardColor)3"),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
                    .cornerRadius(15)
                    .matchedGeometryEffect(id: card.id + "BG", in: animation)
            }
        }
    }
    
    @ViewBuilder
    func CardView(card: Card)->some View{
        VStack(spacing: 15){
            
            if tabData.showDetail && tabData.currentCard == card{
                
                Image(card.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom)
                    .opacity(0)
                
                Text(card.title)
                    .font(.title2.bold())
                    .opacity(0)
            }
            else{
                Image(card.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: card.id + "IMAGE", in: animation)
                    .padding(.bottom)
                
                Text(card.title)
                    .font(.title2.bold())
                    .matchedGeometryEffect(id: "\(card.id)TITLE", in: animation)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Custom Hoverable Card Button...
struct CardButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        
        return configuration.label
        // decreasing scale when clicked...
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .animation(.easeIn, value: configuration.isPressed)
    }
}

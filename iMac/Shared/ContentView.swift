//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 12/07/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        ZStack{
            
            // Screen....
            ScreenView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 1500, height: 1200))
    }
}

struct ScreenView: View{
    
    var body: some View{
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 25)
                .fill(Color("Purple"))
            
            // Apple Logo...
            Image(systemName: "applelogo")
                .font(.system(size: 180))
                .foregroundColor(Color("Logo"))
                .offset(y: -60)
            
            // Usb Ports....
            HStack(spacing: 20){
                
                TypeC()
                
                TypeC()
                
                TypeC(thunderbolt: true)
                
                TypeC(thunderbolt: true)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .offset(x: 130, y: -40)
            
            // Power Button....
            ZStack{
                
                Circle()
                    .fill(Color("Purple"))
                
                Image(systemName: "power")
                    .font(.system(size: 13))
                    .foregroundColor(Color("Stand").opacity(0.7))
            }
            .frame(width: 33, height: 33)
            // Inner Shadows....
            .overlay(
            
                Circle()
                    .stroke(Color("DarkPurple").opacity(0.1),lineWidth: 3)
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 5, y: 5)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.4), radius: 5, x: -5, y: -5)
                    .clipShape(Circle())
            )
            // Bottom Inner Shadow...
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .offset(x: -50, y: -35)
            
            // Stand View...
            StandView()
        }
        .frame(width: 1000, height: 700)
    }
}

struct TypeC: View{
    
    var thunderbolt: Bool = false
    
    var body: some View{
        
        VStack(spacing: 5){
            
            // showing thunderbolt logo if true...
            Image("thunderbolt")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 8, height: 8)
                .foregroundColor(Color("Logo").opacity(0.6))
                .opacity(thunderbolt ? 1 : 0)
            
            ZStack{
                
                Capsule()
                    .fill(.black.opacity(0.6))
                    .frame(width: 6, height: 18)
                
                Capsule()
                    .fill(Color("Stand").opacity(0.2))
                    .frame(width: 2, height: 14)
                    .overlay(
                    
                        VStack{
                        
                        Capsule()
                            .fill(Color("Logo").opacity(0.7))
                            .frame(width: 1, height: 1)
                        
                        Spacer()
                        
                        Capsule()
                            .fill(Color("Logo").opacity(0.7))
                            .frame(width: 1, height: 1)
                        }
                    )
            }
        }
    }
}

struct StandView: View{
    
    var body: some View{
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 2)
                .fill(Color("Stand"))
                .frame(width: 220, height: 320)
            // TOp Shadow...
                .overlay(
                
                    RoundedRectangle(cornerRadius: 2)
                        .fill(
                        
                            LinearGradient(
                                colors: [
                                
                                    .white.opacity(0.8),
                                ] + Array(repeating: Color("Stand"), count: 4),
                                startPoint: .top,
                                endPoint: .bottom)
                        )
                        .frame(height: 55)
                    
                    ,alignment: .top
                )
            // Bottom Shadow...
                .overlay(
                
                    RoundedRectangle(cornerRadius: 2)
                        .fill(
                        
                            LinearGradient(
                                colors: [
                                
                                    Color("Stand"),
                                    .white.opacity(0.3),
                                    .white.opacity(0.4),
                                    .white.opacity(0.7),
                                ],
                                startPoint: .top,
                                endPoint: .bottom)
                        )
                        .frame(height: 20)
                        .offset(y: 10)
                    
                    ,alignment: .bottom
                )
                //.clipped()
            
            // Power Cord....
            ZStack{
                
                Capsule()
                    .fill(Color("Purple"))
                
                // Cord...
                CordView()
                    
            }
            .frame(width: 50, height: 90)
            .offset(y: -35)
            
            // BottomStand...
            BottomStand()
                .offset(y: 160)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .offset(y: 150)
    }
}

struct BottomStand: View{
    
    var body: some View{
        
        ZStack(alignment: .bottom){
            
            HStack{
                
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color("Logo"))
                    .frame(width: 30, height: 3)
                    .offset(y: 2)
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color("Logo"))
                    .frame(width: 30, height: 3)
                    .offset(y: 2)
            }
            .padding(.horizontal,4)
            
            ZStack{
                
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color("Stand"))
                // shadow...
                    .shadow(color: .black.opacity(0.12), radius: 5, x: 0, y: -5)
                
                // Shadow on both edges....
                Rectangle()
                // gradient....
                    .fill(
                    
                        .linearGradient(
                            .init(colors: getGradient()),
                            startPoint: .leading,
                            endPoint: .trailing)
                    )
            }
        }
        .frame(width: 220, height: 10)
    }
    
    func getGradient()->[Color]{
        
        let stand = Array(repeating: Color("Stand"), count: 20)
        
        let colors: [Color] = [
        
            .white.opacity(0.1),
            .white.opacity(0.2),
            // Increasing Stand color to get exact shadow...
        ]
        
        let gradient = colors + stand + colors.reversed()
        
        return gradient
    }
}

struct CordView: View{
    
    var body: some View{
        
        ZStack{
            
            Circle()
                .stroke(.black,lineWidth: 0.5)
            
            // Inner View....
            ZStack{
                Circle()
                
                Circle()
                    .fill(
                    
                        LinearGradient(
                            colors: [
                            
                                .white.opacity(0.4),
                                .gray,
                                .black.opacity(0.6)
                            ],
                            startPoint: .top,
                            endPoint: .bottom)
                    )
                    .padding(.bottom,1)
                    .offset(y: 1)
                
                // Inner Connecting Points....
                ZStack{
                    
                    Circle()
                        .stroke(.white.opacity(0.5),lineWidth: 1.5)
                        .padding(5)
                    
                    Circle()
                        .stroke(.black.opacity(0.9),lineWidth: 1)
                        .padding(4)
                    
                    Circle()
                        .fill(
                        
                            .linearGradient(
                                .init(colors: [
                                
                                    .black,
                                    .black.opacity(0.8),
                                    .black.opacity(0.2)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom)
                        )
                        .padding(6)
                    
                    ZStack{
                        
                        Circle()
                            .fill(.gray.opacity(0.5))
                        
                        // Side Dots...
                        Rectangle()
                            .fill(.gray.opacity(0.8))
                            .frame(width: 1, height: 1.5)
                            .offset(x: -3.3, y: 0.5)
                        
                        Rectangle()
                            .fill(.gray.opacity(0.8))
                            .frame(width: 1, height: 1.5)
                            .offset(x: 3.3, y: 0.5)
                    }
                    .padding(8)
                }
            }
            .frame(width: 20, height: 20)
            
            Circle()
                .stroke(.linearGradient(
                    .init(colors: [
                    
                        .white.opacity(0.7),
                        .gray,
                        .black.opacity(0.5)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom),
                lineWidth: 3)
                .frame(width: 24, height: 24)
        }
        .frame(width: 28, height: 28)
        .offset(y: -10)
    }
}

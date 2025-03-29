//
//  SplashScreen.swift
//  SplashScreen
//
//  Created by Balaji on 15/08/21.
//

import SwiftUI

struct SplashScreen: View {
    
    // Animation Properties...
    @State var startAnimation = false
    @State var bowAnimation = false
    
    // Glow Animation...
    @State var glow = false
    
    // Plus Image...
    @State var showPlus = false
    @State var plusBGGlow = false
    
    @State var isFinished = false
    
    var body: some View {
        
        // For Saftey...
        HStack{
            
            if !isFinished{
                
                ZStack{
                    
                    Color("BG")
                        .ignoresSafeArea()
                    
                    // Disney Logo...
                    GeometryReader{proxy in
                        
                        // For Screen Size...
                        let size = proxy.size
                        
                        ZStack{
                            
                            // RainBow...
                            Circle()
                            // Trimming...
                                .trim(from: 0, to: bowAnimation ? 0.5 : 0)
                                .stroke(
                                
                                    // Gradient...
                                    .linearGradient(.init(colors: [
                                    
                                        Color("Gradient1"),
                                        Color("Gradient2"),
                                        Color("Gradient3"),
                                        Color("Gradient5"),
                                        Color("Gradient5")
                                            .opacity(0.5),
                                        Color("BG"),
                                        Color("BG"),
                                        Color("BG"),
                                        
                                    ]), startPoint: .leading, endPoint: .trailing)
                                    
                                    ,style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round)
                                )
                                .overlay(
                                
                                    // Glow Circle...
                                    Circle()
                                        .fill(Color.white.opacity(0.4))
                                        .frame(width: 6, height: 6)
                                        .overlay(
                                        
                                            Circle()
                                                .fill(Color.white.opacity(glow ? 0.2 : 0.1))
                                                .frame(width: 20, height: 20)
                                        )
                                        .blur(radius: 2.5)
                                    // Moving towards left....
                                        .offset(x: (size.width / 2) / 2)
                                    // moving towards bow...
                                        .rotationEffect(.init(degrees: bowAnimation ? 180 : 0))
                                        .opacity(startAnimation ? 1 : 0)
                                    
                                )
                                .frame(width: size.width / 2, height: size.width / 2)
                                .rotationEffect(.init(degrees: -200))
                                .offset(y: 10)
                            
                            HStack(spacing: -20){
                            
                                Image("disney")
                                    .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: size.width / 1.9, height: size.width / 1.9)
                                    .opacity(bowAnimation ? 1 : 0)
                                
                                // Plus Image...
                                Image("plus")
                                    .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                // Background Glow...
                                    .background(
                                    
                                        ZStack{
                                            
                                            Circle()
                                                .fill(Color.white.opacity(0.25))
                                                .frame(width: 20, height: 20)
                                                .blur(radius: 2)
                                            
                                            Circle()
                                                .fill(Color.white.opacity(0.2))
                                                .frame(width: 35, height: 35)
                                                .blur(radius: 2)
                                        }
                                        .opacity(plusBGGlow ? 1 : 0)
                                    )
                                    .scaleEffect(showPlus ? 1 : 0)
                                
                            }
                            .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        
                    }
                }
                .onAppear {
                    
                    // Delaying 0.3s....
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        
                        withAnimation(.linear(duration: 2)){
                            bowAnimation.toggle()
                        }
                        
                        // Glow Animation...
                        withAnimation(.linear(duration: 1).repeatForever(autoreverses: true)){
                            glow.toggle()
                        }
                        
                        // Since we dont need glow from bottom of disney so delaying animation...
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            
                            withAnimation(.spring()){
                                startAnimation.toggle()
                            }
                        }
                        
                        // hiding glow before hitting plus image....
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            
                            withAnimation(.spring()){
                                showPlus.toggle()
                                startAnimation.toggle()
                            }
                        }
                        
                        // Glowing after hitting plus image...
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                            
                            withAnimation(.linear(duration: 0.5)){
                                plusBGGlow.toggle()
                            }
                            
                            // Toogling back after 0.5s...
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                
                                withAnimation(.linear(duration: 0.4)){
                                    plusBGGlow.toggle()
                                }
                                
                                // After 0.4s finishing splash animation...
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    
                                    withAnimation{
                                        isFinished.toggle()
                                    }
                                }

                            }
                        }
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

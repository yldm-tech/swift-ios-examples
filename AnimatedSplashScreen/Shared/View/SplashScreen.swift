//
//  SplashScreen.swift
//  AnimatedSplashScreen (iOS)
//
//  Created by Balaji on 26/06/21.
//

import SwiftUI

// Custom View Builder....
struct SplashScreen<Content: View,Title: View,Logo: View,NavButton: View>: View {
    
    var content: Content
    var titleView: Title
    var logoView: Logo
    var navButton: NavButton
    
    var imageSize: CGSize
    
    // Navbuttons...
    
    init(imageSize: CGSize,@ViewBuilder content: @escaping () -> Content,@ViewBuilder titleView: @escaping () -> Title,@ViewBuilder logoView: @escaping () -> Logo,@ViewBuilder navButtons: @escaping () -> NavButton){
        
        self.content = content()
        self.titleView = titleView()
        self.logoView = logoView()
        self.navButton = navButtons()
        
        self.imageSize = imageSize
    }
    
    // Animation Properties...
    @State var textAnimation = false
    @State var imageAnimation = false
    @State var endAnimation = false
    
    @State var showNavButtons = false
    
    // NameSpace...
    @Namespace var animation
    
    var body: some View {
        
        VStack(spacing: 0){
            
            ZStack{
                
                Color("Purple")
                // were not going to do complex reading of top edge...
                // simply apply overlay or background it will automatically fill edges...
                    .background(Color("Purple"))
                // But the frame will be safe area....
                
                // I dont know why its giving opacity effect when moving....
                // Workaround use Overlay
                    .overlay(
                    
                        ZStack{
                            
                            titleView
                            // scaling Text...
                                .scaleEffect(endAnimation ? 0.75 : 1)
                                .offset(y: textAnimation ? -5 : 110)
                            
                            if !endAnimation{
                                
                                logoView
                                    .matchedGeometryEffect(id: "LOGO", in: animation)
                                    .frame(width: imageSize.width, height: imageSize.height)
                            }
                        }
                    )
                    .overlay(
                    
                        // Moving Right...
                        
                        HStack{
                            
                            // Later Used for nav Buttons...
                            navButton
                                .opacity(showNavButtons ? 1 : 0)
                            
                            Spacer()
                         
                            if endAnimation{
                                
                                logoView
                                    .matchedGeometryEffect(id: "LOGO", in: animation)
                                    .frame(width: 30, height: 30)
                                    
                            }
                        }
                        .padding(.horizontal)
                    )
            }
            // decreasing size when animation ended...
            // Your own Value.....
            .frame(height: endAnimation ? 60 : nil)
            .zIndex(1)
            
            // HOme View.....
            content
                .frame(height: endAnimation ? nil : 0)
            // moving back view...
                .zIndex(0)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
            
            // Starting Animation with some delay...
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                
                withAnimation(.spring()){
                    
                    textAnimation.toggle()
                }
                
                // Directly Ending Animation...
                withAnimation(Animation.interactiveSpring(response: 0.6, dampingFraction: 1, blendDuration: 1)){
                    
                    endAnimation.toggle()
                }
                
                // Showing after some Delay....
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    
                    withAnimation{
                        showNavButtons.toggle()
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

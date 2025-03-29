//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 22/03/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        NavigationView{
            Home()
                .navigationTitle("Dribbble Ball Animation")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    // Properties...
    @State var rotateBall = false
    @State var showPopUp = false
    
    // Color Scheme for dark Mode adoption...
    @Environment(\.colorScheme) var scheme
    
    var body: some View{
        
        VStack{
            
            Toggle(isOn: $rotateBall, label: {
                
                Text("Rotate Ball")
            })
            .padding()
            .padding(.vertical)
            
            // Custom Shadow Button...
            Button(action: {
                
                withAnimation(.spring()){showPopUp.toggle()}
                
            }, label: {
                Text("Show PopUp")
                    .foregroundColor(.primary)
                    .padding(.vertical,10)
                    .padding(.horizontal,25)
                    .background(scheme == .dark ? Color.black : Color.white)
                    .cornerRadius(8)
                    // Shadows...
                    .shadow(color: Color.primary.opacity(0.1), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.primary.opacity(0.1), radius: 5, x: -5, y: -5)
            })
        }
        // Max Frame...
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
        
            ZStack{
                
                if showPopUp{
                    Color.primary.opacity(0.2)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.spring()){showPopUp.toggle()}
                        }
                    
                    // Sliding From Bottom....
                    DribbleAnimatedView(showPopup: $showPopUp, rotateBall: $rotateBall)
                        //.offset(y: showPopUp ? 0 : UIScreen.main.bounds.height)
                }
            }
        )
    }
}

// Dribble Loader...

struct DribbleAnimatedView: View {
    
    // Color Scheme for dark Mode adoption...
    @Environment(\.colorScheme) var scheme
    
    // Porperties...
    @Binding var showPopup : Bool
    @Binding var rotateBall: Bool
    
    // Animation Properties..
    @State var animateBall = false
    @State var animateRotation = false
    
    var body: some View{
        
        ZStack{
            
            (scheme == .dark ? Color.black : Color.white)
                .frame(width: 150, height: 150)
                .cornerRadius(14)
                // Shadows...
                .shadow(color: Color.primary.opacity(0.07), radius: 5, x: 5, y: 5)
                .shadow(color: Color.primary.opacity(0.07), radius: 5, x: -5, y: -5)
            
            
            // Ball Shadow...
            
            Circle()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 40, height: 40)
            // Rotating in X Axis...
                .rotation3DEffect(
                    .init(degrees: 60),
                    axis: (x: 1, y: 0, z: 0.0),
                    anchor: .center,
                    anchorZ: 0.0,
                    perspective: 1.0
                )
                .offset(y: 35)
                .opacity(animateBall ? 1 : 0)
            
            Image("dribble")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .rotationEffect(.init(degrees: rotateBall && animateRotation ? 360 : 0))
                .offset(y: animateBall ? 10 : -25)
            
        }
        .onAppear(perform: {
            doAnimation()
        })
    }
    
    func doAnimation(){
        
        withAnimation(Animation.easeInOut(duration: 0.4).repeatForever(autoreverses: true)){
            animateBall.toggle()
        }
        
        withAnimation(Animation.linear(duration: 0.8).repeatForever(autoreverses: false)){
            
            animateRotation.toggle()
        }
    }
}

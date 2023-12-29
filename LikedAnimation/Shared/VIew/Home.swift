//
//  Home.swift
//  Home
//
//  Created by Balaji on 04/09/21.
//

import SwiftUI

struct Home: View {
    
    // Sample Posts...
    @State var posts: [Post] = [
    
        Post(imageName: "Pic1"),
        Post(imageName: "Pic2"),
        Post(imageName: "Pic3"),
        Post(imageName: "Pic4"),
        Post(imageName: "Pic5"),
    ]
    
    var body: some View {
        
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    ForEach(posts){post in
                        
                        VStack(alignment: .leading, spacing: 12) {
                            
                            GeometryReader{proxy in
                                
                                Image(post.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(15)
                            }
                            .frame(height: 280)
                            // Adding Overlay...
                            .overlay(
                            
                                HeartLike(isTapped: $posts[getIndex(post: post)].isLiked, taps: 2)
                            )
                            .cornerRadius(15)
                            
                            Button {
                                posts[getIndex(post: post)].isLiked.toggle()
                            } label: {
                                Image(systemName: post.isLiked ? "suit.heart.fill" : "suit.heart")
                                    .font(.title2)
                                    .foregroundColor(post.isLiked ? .red : .gray)
                            }

                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Heart Animation")
        }
    }
    
    // getting Index...
    func getIndex(post: Post)->Int{
        
        let index = posts.firstIndex { currentPost in
            return currentPost.id == post.id
        } ?? 0
        
        return index
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HeartLike: View{
    
    // Animation Properites....
    @Binding var isTapped: Bool
    
    @State var startAnimation = false
    @State var bgAniamtion = false
    // Resetting Bg....
    @State var resetBG = false
    @State var fireworkAnimation = false
    
    @State var animationEnded = false
    
    // To Avoid Taps during Animation...
    @State var tapComplete = false
    
    // Setting How Many taps...
    var taps: Int = 1
    
    var body: some View{
        
        // Heart Like Animation....
        Image(systemName: resetBG ? "suit.heart.fill" : "suit.heart")
            .font(.system(size: 45))
            .foregroundColor(resetBG ? .red : .gray)
        // Scaling...
            .scaleEffect(startAnimation && !resetBG ? 0 : 1)
            .opacity(startAnimation && !animationEnded ? 1 : 0)
        // BG...
            .background(
            
                ZStack{
                    
                    CustomShape(radius: resetBG ? 29 : 0)
                        .fill(Color.purple)
                        .clipShape(Circle())
                        // Fixed Size...
                        .frame(width: 50, height: 50)
                        .scaleEffect(bgAniamtion ? 2.2 : 0)
                    
                    ZStack{
                        
                        // random Colors..
                        let colors: [Color] = [.red,.purple,.green,.yellow,.pink]
                        
                        ForEach(1...6,id: \.self){index in
                            
                            Circle()
                                .fill(colors.randomElement()!)
                                .frame(width: 12, height: 12)
                                .offset(x: fireworkAnimation ? 80 : 40)
                                .rotationEffect(.init(degrees: Double(index) * 60))
                        }
                        
                        ForEach(1...6,id: \.self){index in
                            
                            Circle()
                                .fill(colors.randomElement()!)
                                .frame(width: 8, height: 8)
                                .offset(x: fireworkAnimation ? 64 : 24)
                                .rotationEffect(.init(degrees: Double(index) * 60))
                                .rotationEffect(.init(degrees: -45))
                        }
                    }
                    .opacity(resetBG ? 1 : 0)
                    .opacity(animationEnded ? 0 : 1)
                }
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .contentShape(Rectangle())
            .onTapGesture(count: taps){
                
                if tapComplete{
                    
                    updateFields(value: false)
                    // resettin back...
                    return
                }
                
                
                if startAnimation{
                    return
                }
                
                isTapped = true
                
                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                    
                    startAnimation = true
                }
                
                // Sequnce Animation...
                // Chain Animation...
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    
                    withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)){
                        
                        bgAniamtion = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                            
                            resetBG = true
                        }
                        
                        // Fireworks...
                        withAnimation(.spring()){
                            fireworkAnimation = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            
                            withAnimation(.easeOut(duration: 0.4)){
                                animationEnded = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                tapComplete = true
                            }
                        }
                    }
                }
            }
            .onChange(of: isTapped) { newValue in
                if isTapped && !startAnimation{
                    // setting everything to true...
                    updateFields(value: true)
                }
                
                if !isTapped{
                    updateFields(value: false)
                }
            }
    }
    
    func updateFields(value: Bool){
        
        startAnimation = value
        bgAniamtion = value
        resetBG = value
        fireworkAnimation = value
        animationEnded = value
        tapComplete = value
        isTapped = value
    }
}

// Custom Shape
// For Resetting from center...
struct CustomShape: Shape{
    
    // value...
    var radius: CGFloat
    
    // animating Path...
    var animatableData: CGFloat{
        get{return radius}
        set{radius = newValue}
    }
    
    // Animatable path wont work on previews....
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
            // adding Center Circle....
            let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
            path.move(to: center)
            path.addArc(center: center, radius: radius, startAngle: .zero, endAngle: .init(degrees: 360), clockwise: false)
        }
    }
}

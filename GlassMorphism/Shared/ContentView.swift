//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 02/08/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View{
    
    var body: some View{
        
        ZStack{
            
            LinearGradient(
                colors: [Color("BG1"),Color("BG2")],
                startPoint: .top,
                endPoint: .bottom)
                .ignoresSafeArea()
            
            // Gloss Background....
            GeometryReader{proxy in
                
                let size = proxy.size
                
                // Slighlty Darkening ...
                Color.black
                    .opacity(0.7)
                    .blur(radius: 200)
                    .ignoresSafeArea()
                
                Circle()
                    .fill(Color("Purple"))
                    .padding(50)
                    .blur(radius: 120)
                // Moving Top...
                    .offset(x: -size.width / 1.8, y: -size.height / 5)
                
                Circle()
                    .fill(Color("LightBlue"))
                    .padding(50)
                    .blur(radius: 150)
                // Moving Top...
                    .offset(x: size.width / 1.8, y: -size.height / 2)
                
                
                Circle()
                    .fill(Color("LightBlue"))
                    .padding(50)
                    .blur(radius: 90)
                // Moving Top...
                    .offset(x: size.width / 1.8, y: size.height / 2)
                
                // Adding Purple on both botom ends...
                
                Circle()
                    .fill(Color("Purple"))
                    .padding(100)
                    .blur(radius: 110)
                // Moving Top...
                    .offset(x: size.width / 1.8, y: size.height / 2)
                
                Circle()
                    .fill(Color("Purple"))
                    .padding(100)
                    .blur(radius: 110)
                // Moving Top...
                    .offset(x: -size.width / 1.8, y: size.height / 2)
            }
            
            // Content....
            VStack{
                
                Spacer(minLength: 10)
                
                // GlassMorphism Card...
                
                ZStack{
                    
                    
                    // Bacground Balls...
                    Circle()
                        .fill(Color("Purple"))
                        .blur(radius: 20)
                        .frame(width: 100, height: 100)
                        .offset(x: 120, y: -80)
                    
                    Circle()
                        .fill(Color("LightBlue"))
                        .blur(radius: 40)
                        .frame(width: 100, height: 100)
                        .offset(x: -120, y: 100)
                    
                    GlassMorphicCard()
                }
                
                Spacer(minLength: 10)
                
                
                // Adapting for small devices...
                Text("Know Everything\nabout the weather")
                    .font(.system(size: UIScreen.main.bounds.height < 750 ? 30 : 40, weight: .bold))
                
                Text(getAttributedString())
                    .fontWeight(.semibold)
                    .kerning(1.1)
                    .padding(.top,10)
                
                // Button...
                Button {
                    
                } label: {
                    Text("Get Started")
                        .font(.title3.bold())
                        .padding(.vertical,22)
                        .frame(maxWidth: .infinity)
                        .background(
                        
                            .linearGradient(.init(colors: [
                            
                                Color("Button11"),
                                Color("Button12"),
                            ]), startPoint: .leading, endPoint: .trailing)
                            
                            ,in: RoundedRectangle(cornerRadius: 20)
                        )
                }
                .padding(.horizontal,50)
                .padding(.vertical,20)
                
                Button {
                    
                } label: {
                    Text("Already have an account?")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
                .padding(.bottom)


            }
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding()
        }
    }
    
    // going to use AttributesString from iOS 15...
    func getAttributedString()->AttributedString{
        
        var attStr = AttributedString("Start now and learn more about \n local weather instantly")
        attStr.foregroundColor = .gray
        
        // converting only 'local weather...'
        if let range = attStr.range(of: "local weather"){
            // changing into white...
            attStr[range].foregroundColor = .white
        }
        
        return attStr
    }
}


struct GlassMorphicCard: View{
    
    var body: some View{
        
        let width = UIScreen.main.bounds.width
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .opacity(0.1)
                .background(
                
                    Color.white
                        .opacity(0.08)
                        .blur(radius: 10)
                )
            // Strokes...
                .background(
                
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(
                        
                            .linearGradient(.init(colors: [
                            
                                Color("Purple"),
                                Color("Purple").opacity(0.5),
                                .clear,
                                .clear,
                                Color("LightBlue"),
                            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            ,lineWidth: 2.5
                        )
                        .padding(2)
                )
            // Shadows...
                .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
            
            // COntent...
            VStack{
                
                Image(systemName: "sun.max")
                    .font(.system(size: 75, weight: .thin))
                
                Text("18")
                    .font(.system(size: 85, weight: .bold))
                    .padding(.top,2)
                    .overlay(
                    
                        Text("˚C")
                            .font(.title2)
                            .foregroundColor(Color.white.opacity(0.7))
                            .offset(x: 30, y: 15)
                        
                        ,alignment: .topTrailing
                    )
                    .offset(x: -6)
                
                Text("Cracow, Poland")
                    .font(.title3)
                    .foregroundColor(Color.white.opacity(0.4))
            }
        }
        .frame(width: width / 1.7, height: 270)
    }
}

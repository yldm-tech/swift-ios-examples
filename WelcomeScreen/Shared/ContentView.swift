//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 14/05/21.
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
            .previewDevice("iPhone 8")
    }
}

struct Home: View {
    
    @State var currentIndex : Int = 1
    
    var body: some View{
        
        VStack{
            
            let isSmallDevice = UIScreen.main.bounds.height < 750
            
            // Custom Page Tab Bar...
            // Or Carousel SLider...
            TabView(selection: $currentIndex){
                
                ForEach(1...3,id: \.self){index in
                    
                    // For Cusotm Scroll Effect...
                    GeometryReader{proxy -> AnyView in
                        
                        let minX = proxy.frame(in: .global).minX
                        
                        let width = UIScreen.main.bounds.width
                        
                        let progress = -minX / (width * 2)
                        
                        var scale = progress > 0 ? 1 - progress : 1 + progress
                        
                        scale = scale < 0.7 ? 0.7 : scale
                        
                        return AnyView(
                        
                            VStack{
                                
                                Image("pic\(index)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.horizontal,20)
                                    .frame(maxHeight: .infinity, alignment: .center)
                                
                                Text("Pet Adoption")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .padding(.top,20)
                                
                                Text("Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out.")
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.top,10)
                            }
                            .padding(.top,isSmallDevice ? 10 : 0)
                            .frame(maxHeight: .infinity, alignment: .center)
                            .scaleEffect(scale)
                        )
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            // Custom Tab Indicator...
            
            CustomTabIndicator(count: 3, current: $currentIndex)
                .padding(.vertical,isSmallDevice ? 10 : 15)
                .padding(.top)
            
            // Login Buttons....
            
            VStack(spacing: 15){
                
                Button(action: {}, label: {
                    
                    HStack{
                        
                        Image(systemName: "applelogo")
                            // since were having images from assests...
                            // to maintain same size were using custom size rather then font...
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                        
                        Text("Sign up with Apple  ")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.vertical,13)
                    .padding(.horizontal)
                    .background(
                    
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.black)
                            .overlay(
                            
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white,lineWidth: 1)
                            )
                    )
                })
                
                Button(action: {}, label: {
                    
                    HStack{
                        
                        Image("google")
                            // since were having images from assests...
                            // to maintain same size were using custom size rather then font...
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                        
                        Text("Sign up with Google")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.vertical,13)
                    .padding(.horizontal)
                    .background(
                    
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .overlay(
                            
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black,lineWidth: 1.5)
                            )
                    )
                })
                
                Button(action: {}, label: {
                    
                    HStack{
                        
                        Image("email")
                            // since were having images from assests...
                            // to maintain same size were using custom size rather then font...
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                        
                        Text("Sign up with Email    ")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.vertical,13)
                    .padding(.horizontal)
                    .background(
                    
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .overlay(
                            
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black,lineWidth: 1.5)
                            )
                    )
                })
                
                HStack{
                    
                    Text("Already have an account?")
                        .foregroundColor(.white)
                    
                    Button(action: {}, label: {
                        Text("Login")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .underline(true, color: Color.white)
                    })
                }
                .padding(.top,30)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("bg").ignoresSafeArea())
    }
}


struct CustomTabIndicator: View {
    
    var count: Int
    @Binding var current: Int
    
    var body: some View{
        
        HStack{
            
            ForEach(0..<count,id: \.self){index in
                
                ZStack{
                    
                    // since our image index starts from 1...
                    if (current - 1) == index{
                        
                        Circle()
                            .fill(Color.black)
                    }
                    else{
                        
                        Circle()
                            .fill(Color.white)
                            .overlay(
                            
                                Circle()
                                    .stroke(Color.black,lineWidth: 1.5)
                            )
                    }
                }
                .frame(width: 10, height: 10)
            }
        }
    }
}

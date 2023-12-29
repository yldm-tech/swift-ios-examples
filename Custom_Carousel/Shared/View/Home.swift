//
//  Home.swift
//  Custom_Carousel (iOS)
//
//  Created by Balaji on 23/04/21.
//

import SwiftUI

struct Home: View {
    // To capture the current tab...
    @State var selectedTab: Trip = trips[0]
    
    // disabling bounces...
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        
        ZStack{
            
            // to get screen size for image...
            GeometryReader{proxy in
                
                let frame = proxy.frame(in: .global)
                
                Image(selectedTab.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: frame.width, height: frame.height, alignment: .center)
                    // Why we using corner radius
                    // because image in SwiftUI using .fill
                    // will require corner radius or clipshape to cut the image....
                    .cornerRadius(0)
            }
            .ignoresSafeArea()
            
            // Custom Carousel...
            
            VStack{
                
                Text("Let's Go With")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Pocotrip")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.bottom,30)
                
                // Carousel...
                
                VStack {
                    
                    GeometryReader{proxy in
                        
                        let frame = proxy.frame(in: .global)
                        
                        // Page tab View...
                        TabView(selection: $selectedTab){
                            
                            ForEach(trips){trip in
                                
                                Image(trip.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: frame.width - 10, height: frame.height, alignment: .center)
                                    .cornerRadius(4)
                                    .tag(trip)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                    // max Limit
                    // half of the screen...
                    .frame(height: UIScreen.main.bounds.height / 2.2)
                    
                    Text(selectedTab.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top,20)
                        .padding(.bottom,18)
                    
                    // Page Control From UIKit...
                    PageControl(maxPages: trips.count, currentPage: getIndex())
                }
                .padding(.top)
                .padding(.horizontal,10)
                .padding(.bottom,5)
                // Going to clip it using custom Shape...
                .background(Color.white.clipShape(CustomShape()).cornerRadius(10))
                .padding(.horizontal,20)
                
                Button(action: {}, label: {
                    Text("GET STARTED")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical,18)
                        .frame(maxWidth: .infinity)
                        .background(Color("blue"))
                        .cornerRadius(10)
                })
                .padding(.top,30)
                .padding(.horizontal)
            }
            .padding()
        }
    }
    
    // getting Index...
    func getIndex()->Int{
        
        let index = trips.firstIndex { (trip) -> Bool in
            return selectedTab.id == trip.id
        } ?? 0
        
        return index
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

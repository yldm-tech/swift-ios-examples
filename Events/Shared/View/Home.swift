//
//  Home.swift
//  Home
//
//  Created by Balaji on 23/07/21.
//

import SwiftUI

struct Home: View {
    
    // Gesture Properties...
    @GestureState var pinchStarted: Bool = false
    @State var pinchValue: CGFloat = 0
    @State var lastPinch: CGFloat = 0
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 18){
                
                ForEach(events){event in
                    
                    // Event Card View....
                    EventCardView(event: event,pinchValue: $pinchValue)
                }
            }
            .padding([.vertical,.leading])
        }
        // Adding Maginifcation Gesture...
        .gesture(
        
            MagnificationGesture()
                .updating($pinchStarted, body: { value, out, _ in
                    out = true
                })
                .onChanged({ value in
                    // if pinch is started then updating pinch value...
                    // this will avoid invalid touches...
                    
                    if pinchStarted{
                        
                        // forward pinch will start from 1
                        // reverse pinch will start from 1 and ends at 0...
                        // so we need to convert that to 4.5....
                        
                        // so crt pinch Value...
                        
                        // adding lastpinch...
                        let delta = lastPinch + ((value - 1) > 0 ? (value - 1) : (value - 1) * 4.5)
                        // crt delta....
                        var absoluteDelta = delta > 0 ? delta : 0
                        absoluteDelta = absoluteDelta < 4.5 ? absoluteDelta : 4.5
                        // why 4.5?
                        // maxHeight 180 / 40 = 4.5...
                        self.pinchValue = absoluteDelta
                    }
                })
                .onEnded({ value in
                    
                    withAnimation(.easeOut){
                        
                        if pinchValue > 2{
                            // expanded...
                            pinchValue = 4.5
                            lastPinch = 4.5
                        }
                        else{
                            pinchValue = 0
                            lastPinch = 0
                        }
                    }
                })
        )
        
        .safeAreaInset(edge: .top, content: {
            
            // Top Custom Navigation Bar...
            HStack{
                
                Text("Event's")
                    .font(.largeTitle.bold())
                    .foregroundColor(.primary)
                
                Spacer(minLength: 0)
                
                Button {
                    
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.title)
                        .foregroundColor(.primary)
                }

            }
            .padding()
            .background(.ultraThinMaterial)
        })
        // BG Color...
        .background(Color.primary.opacity(0.05))
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

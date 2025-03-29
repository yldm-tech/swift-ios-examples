//
//  Home.swift
//  ScratchCard (iOS)
//
//  Created by Balaji on 04/06/21.
//

import SwiftUI

struct Home: View {
    @State var onFinish: Bool = false
    var body: some View {
        
        VStack{
            
            // Scratch Card View....
            
            ScratchCardView(cursorSize: 50,onFinish: $onFinish) {
                
                // Body COntent...
                
                VStack{
                    
                    Image("trophy")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(10)
                    
                    Text("You've Won")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    Text("$199.78")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding(.top,5)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                
            } overlayView: {
                
                // Overlay Image or View...
                Image("scratch")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }

        }
        // to avoid Spacers...
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
        .overlay(
        
            HStack(spacing: 15){
                
                Button(action: {}, label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.white)
                })
                
                Text("Scratch Card")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer(minLength: 0)
                
                Button(action: {
                    onFinish = false
                }, label: {
                    Image("pic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 55, height: 55)
                        .clipShape(Circle())
                })
            }
            .padding()
            
            ,alignment: .top
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// Custom View...
// Using View Builder...

struct ScratchCardView<Content: View,OverlayView: View>: View {
    
    var content: Content
    var overlayView: OverlayView
    
    init(cursorSize: CGFloat,onFinish: Binding<Bool>,@ViewBuilder content: @escaping ()->Content,@ViewBuilder overlayView: @escaping ()->OverlayView) {
        self.content = content()
        self.overlayView = overlayView()
        self.cursorSize = cursorSize
        self._onFinish = onFinish
    }
    
    // For Scratch Effect...
    @State var startingPoint: CGPoint = .zero
    @State var points: [CGPoint] = []
    
    // For Gesure Updates...
    @GestureState var gestureLocation: CGPoint = .zero
    
    // Customisation and on finish....
    var cursorSize: CGFloat
    @Binding var onFinish: Bool
    
    var body: some View{
        
        ZStack{
            
            overlayView
                .opacity(onFinish ? 0 : 1)
            
            // Logic is when user starts scratching the main Content will starts visible
            // based on the user drag location....
            // and showing full content when the user releases the drag....
            content
                .mask(
                    ZStack{
                        if !onFinish{
                            ScratchMask(points: points, startingPoint: startingPoint)
                                .stroke(style: StrokeStyle(lineWidth: cursorSize, lineCap: .round, lineJoin: .round))
                        }
                        else{
                            // Showing Full Content..
                            Rectangle()
                        }
                    }
                )
                .animation(.easeInOut)
                .gesture(
                
                    DragGesture()
                        .updating($gestureLocation, body: { value, out, _ in
                            out = value.location
                            
                            DispatchQueue.main.async {
                                
                                // Updating starting Point...
                                // and adding user drag locations...
                                if startingPoint == .zero{
                                    startingPoint = value.location
                                }
                                
                                points.append(value.location)
                            }
                        })
                        .onEnded({ value in
                            
                            withAnimation{
                                onFinish = true
                            }
                            
                        })
                )
                        
        }
        .frame(width: 300, height: 300)
        .cornerRadius(20)
        .onChange(of: onFinish, perform: { value in
            // Checking and reseting View...
            if !onFinish && !points.isEmpty{
                withAnimation(.easeInOut){
                    resetView()
                }
            }
        })
    }
    
    func resetView(){
        points.removeAll()
        startingPoint = .zero
    }
}

// Scratch Mask Shape..
// it will appear based on user gesture....
struct ScratchMask: Shape {
    
    var points: [CGPoint]
    var startingPoint: CGPoint
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            path.move(to: startingPoint)
            path.addLines(points)
        }
    }
}

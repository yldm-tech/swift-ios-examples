//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 01/04/21.
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

struct Home: View {
    
    // Offset Value...
    // SInce were going to fetch offset for both vertical and horizontal so were using CGPoint....
    @State var offset: CGPoint = .zero
    
    var body: some View{
        
        NavigationView{
            
            CustomScrollView(offset: $offset, showIndicators: true, axis: .vertical, content: {
                
                // Your General SCroll View COntent....
                VStack(spacing: 15){
                    
                    ForEach(1...30,id: \.self){_ in
                        
                        HStack(spacing: 15){
                            
                            Circle()
                                .fill(Color.gray.opacity(0.6))
                                .frame(width: 70, height: 70)
                            
                            VStack(alignment: .leading, spacing: 15, content: {
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.6))
                                    .frame(height: 15)
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.6))
                                    .frame(height: 15)
                                    .padding(.trailing,90)
                            })
                            //.frame(width: 70)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            })
            .navigationTitle("Offset: \(String(format: "%.1f", offset.y))")
        }
    }
}

// Building Custom ScrollView Using View Builder....

struct CustomScrollView<Content: View>: View {
    
    // to Hold Our View....
    // Or to capture the described view...
    var content: Content
    
    @Binding var offset: CGPoint
    var showIndicators: Bool
    var axis: Axis.Set
    
    // since it will carry multiple views....
    // so it will be a closure and it will return View...
    init(offset: Binding<CGPoint>,showIndicators: Bool,axis: Axis.Set,@ViewBuilder content: ()->Content) {
        
        self.content = content()
        self._offset = offset
        self.showIndicators = showIndicators
        self.axis = axis
    }
    
    // Getting Exact Start Offset And Minu from current Offset...
    // So that crt offset will be obtained...
    @State var startOffset: CGPoint = .zero
    
    var body: some View{
        
        ScrollView(axis, showsIndicators: showIndicators, content: {
            
            content
            // Getting Offset....
                .overlay(
                
                    // Using Geomtry Reader to get offset...
                    
                    GeometryReader{proxy -> Color in
                    
                        let rect = proxy.frame(in: .global)
                        
                        if startOffset == .zero{
                            DispatchQueue.main.async {
                                startOffset = CGPoint(x: rect.minX, y: rect.minY)
                            }
                        }
                        
                        DispatchQueue.main.async {
                            
                            // Minus From Current...
                            self.offset = CGPoint(x: startOffset.x - rect.minX, y: startOffset.y - rect.minY)
                        }
                        
                        return Color.clear
                    }
                    // Since were also fetching horizontal offset...
                    // so setting width to full so that minX will be Zero...
                    .frame(width: UIScreen.main.bounds.width, height: 0)
                    
                    ,alignment: .top
                )
        })
    }
}

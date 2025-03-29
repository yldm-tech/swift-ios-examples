//
//  Home.swift
//  ToolBarAnimation
//
//  Created by Balaji on 01/08/22.
//

import SwiftUI

struct Home: View {
    // MARK: Sample Tools
    @State var tools: [Tool] = [
            .init(icon: "scribble.variable", name: "Scribble", color: .purple),
            .init(icon: "lasso", name: "Lasso", color: .green),
            .init(icon: "plus.bubble", name: "Comment", color: .blue),
            .init(icon: "bubbles.and.sparkles.fill", name: "Enhance", color: .orange),
            .init(icon: "paintbrush.pointed.fill", name: "Picker", color: .pink),
            .init(icon: "rotate.3d", name: "Rotate", color: .indigo),
            .init(icon: "gear.badge.questionmark", name: "Settings", color: .yellow)
        ]
    // MARK: Animation Properties
    @State var activeTool: Tool?
    @State var startedToolPosition: CGRect = .zero
    var body: some View {
        VStack{
            // MARK: ToolBar View
            VStack(alignment: .leading, spacing: 12) {
                ForEach($tools) { $tool in
                    // MARK: Tool View
                    ToolView(tool: $tool)
                }
            }
            .padding(.horizontal,10)
            .padding(.vertical,12)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.white.shadow(
                        .drop(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    ).shadow(
                        .drop(color: .black.opacity(0.05), radius: 5, x: -5, y: -5)
                    ))
                    // MARK: Limiting The Background Size
                    // Image Size = 45 + Horizontal Padding = 20
                    // Total = 65
                    .frame(width: 65)
                    .frame(maxWidth: .infinity,alignment: .leading)
            }
            // MARK: Setting Coordinate Space
            .coordinateSpace(name: "AREA")
            // MARK: Gestures
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ value in
                        // MARK: Current Drag Location
                        guard let firstTool = tools.first else{return}
                        if startedToolPosition == .zero{
                            startedToolPosition = firstTool.toolPostion
                        }
                        let location = CGPoint(x: startedToolPosition.midX, y: value.location.y)
                        
                        // Checking If The Location Lies on Any of the Tools
                        // With the Help of Contains Property
                        if let index = tools.firstIndex(where: { tool in
                            tool.toolPostion.contains(location)
                        }),activeTool?.id != tools[index].id{
                            // MARK: Animating Active Tool
                            withAnimation(.interpolatingSpring(stiffness: 230, damping: 22)){
                                activeTool = tools[index]
                            }
                        }
                    }).onEnded({ _ in
                        // MARK: Resetting Active Tool
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 1, blendDuration: 1)){
                            activeTool = nil
                            startedToolPosition = .zero
                        }
                    })
            )
        }
        .padding(15)
        .padding(.top)
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
    }
    
    @ViewBuilder
    func ToolView(tool: Binding<Tool>)->some View{
        HStack(spacing: 5){
            Image(systemName: tool.wrappedValue.icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 45, height: 45)
                .padding(.leading,activeTool?.id == tool.id ? 5 : 0)
                // MARK: Getting Image Location Using Geometry Proxy And Preference Key
                .background {
                    GeometryReader{proxy in
                        let frame = proxy.frame(in: .named("AREA"))
                        Color.clear
                            .preference(key: RectKey.self, value: frame)
                            .onPreferenceChange(RectKey.self) { rect in
                                tool.wrappedValue.toolPostion = rect
                            }
                    }
                }
            
            if activeTool?.id == tool.wrappedValue.id{
                Text(tool.wrappedValue.name)
                    .padding(.trailing,15)
                    .foregroundColor(.white)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(tool.wrappedValue.color.gradient)
        }
        // Image Size - 45, Trailing Padding - 10 , Extra Space - 5
        // Total = 60
        .offset(x: activeTool?.id == tool.wrappedValue.id ? 60 : 0)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: Position Preference Key
struct RectKey: PreferenceKey{
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

//
//  CustomTabBar.swift
//  CustomTabBar
//
//  Created by Balaji on 07/08/21.
//

import SwiftUI

struct CustomTabBar: View {
    var animation: Namespace.ID
    
    // Extracting Screen Size and bottom safe area...
    var size: CGSize
    var bottomEdge: CGFloat
    
    @Binding var currentTab: Tab
    
    // Adding Animation...
    @State var startAnimation: Bool = false
    
    var body: some View {
        
        HStack(spacing: 0){
            
            // TabButtons...
            // Iterating Tab Enum....
            ForEach(Tab.allCases,id: \.rawValue){tab in
                
                TabButton(tab: tab, animation: animation, currentTab: $currentTab) { pressedTab in
                    
                    // Updating Tab...
                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)){
                        startAnimation = true
                    }
                    
                    // After Some delay starting tab Animation...
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)){
                            currentTab = pressedTab
                        }
                    }
                    
                    // After Tab Animation finished resetting main animation...
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                        
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)){
                            startAnimation = false
                        }
                    }
                }
            }
        }
        // Custom Elastic Shape...
        .background(
        
            ZStack{
                
                let animationOffset: CGFloat = (startAnimation ? (startAnimation ? 15 : 18) : (bottomEdge == 0 ? 26 : 27))
                let offset : CGSize = bottomEdge == 0 ? CGSize(width: animationOffset, height: 31) : CGSize(width: animationOffset, height: 36)
                
                Circle()
                    .fill(Color("Purple"))
                    .frame(width: 45, height: 45)
                    .offset(y: 40)
                // same size as Button...
                
                // Adding two circles to create elastic shape...
                Circle()
                    .fill(.white)
                    .frame(width: 45, height: 45)
                    .scaleEffect(bottomEdge == 0 ? 0.85 : 1)
                // trail and error method...
                    .offset(x: offset.width, y: offset.height)
                
                Circle()
                    .fill(.white)
                    .frame(width: 45, height: 45)
                    .scaleEffect(bottomEdge == 0 ? 0.85 : 1)
                // trail and error method...
                    .offset(x: -offset.width, y: offset.height)
            }
            .offset(x: getStartOffset())
            .offset(x: getOffset())
            // Moving to start...
            ,alignment: .leading
        )
        .padding(.horizontal,15)
        .padding(.top,7)
        .padding(.bottom,bottomEdge == 0 ? 23 : bottomEdge)
    }
    
    // getting start Offset...
    func getStartOffset()->CGFloat{
        // padding...
        let reduced = (size.width - 30) / 4
        // 45 = button size...
        let center = (reduced - 45) / 2
        return center
    }
    
    // moving elastic shape..
    func getOffset()->CGFloat{
        let reduced = (size.width - 30) / 4
        // getting index and multiplying with that...
        let index = Tab.allCases.firstIndex { checkTab in
            return checkTab == currentTab
        } ?? 0
        
        return reduced * CGFloat(index)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        // Checking for small devices...
    }
}

struct TabButton: View{
    var tab: Tab
    var animation: Namespace.ID
    @Binding var currentTab: Tab
    // Sending back the result...
    var onTap: (Tab)->()
    
    var body: some View{
        
        // Since we dont need ripple effect while cliking the button...
        // so we re using Ontap...
        Image(systemName: tab.rawValue)
            .foregroundColor(currentTab == tab ? .white : .gray)
        // default Frame...
            .frame(width: 45, height: 45)
            .background(
            
                // Using Matched Geometry Circle...
                ZStack{
                    
                    if currentTab == tab{
                        Circle()
                            .fill(Color("Purple"))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
            )
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                if currentTab != tab{
                    onTap(tab)
                }
            }
    }
}

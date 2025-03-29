//
//  PagerHelper.swift
//  PagerHelper
//
//  Created by Balaji on 26/08/21.
//

import SwiftUI

// Custom View Builder...

struct PagerTabView<Content: View,Label: View>: View {
    
    var content: Content
    var label: Label
    // Tint...
    var tint: Color
    // Selection...
    @Binding var selection: Int
    
    init(tint: Color,selection: Binding<Int>,@ViewBuilder labels: @escaping ()->Label,@ViewBuilder content: @escaping ()->Content){
        self.content = content()
        self.label = labels()
        self.tint = tint
        self._selection = selection
    }
    
    // Offset for Page Scroll...
    @State var offset: CGFloat = 0
    
    @State var maxTabs: CGFloat = 0
    
    @State var tabOffset: CGFloat = 0
    
    @State var isScrolling: Bool = false
    
    var body: some View {
       
        VStack(spacing: 0){
            
            HStack(spacing: 0){
                label
            }
            // For Tap to change tab...
            .overlay(
            
                HStack(spacing: 0){
                    ForEach(0..<Int(maxTabs),id: \.self){index in
                        Rectangle()
                            .fill(Color.black.opacity(0.01))
                            .onTapGesture {
                                // Changing Offset...
                                // Based on Index...
                                let newOffset = CGFloat(index) * getScreenBounds().width
                                self.offset = newOffset
                                withAnimation{
                                    self.tabOffset = CGFloat(index) * (getScreenBounds().width / maxTabs)
                                }
                            }
                    }
                }
            )
            .foregroundColor(tint)
            
            // Indicator...
            Capsule()
                .fill(tint)
                .frame(width: maxTabs == 0 ? 0 : (getScreenBounds().width / maxTabs), height: 5)
                .padding(.top,10)
                .frame(maxWidth: .infinity,alignment: .leading)
                .offset(x: tabOffset)
            
            OffsetPageTabView(selection: $selection,offset: $offset,isScrolling: $isScrolling) {
                
                HStack(spacing: 0){
                    content
                }
                // Getting How many tabs are there by getting the total Content Size...
                .overlay(
                
                    GeometryReader{proxy in
                        
                        Color.clear
                            .preference(key: TabPreferenceKey.self, value: proxy.frame(in: .global))
                    }
                )
                // When value Changes...
                .onPreferenceChange(TabPreferenceKey.self) { proxy in
                    
                    let minX = -proxy.minX
                    let maxWidth = proxy.width
                    let screenWidth = getScreenBounds().width
                    let maxTabs = (maxWidth / screenWidth).rounded()
                    
                    // Getting Tab Offset...
                    let progress = minX / screenWidth
                    let tabOffset = progress * (screenWidth / maxTabs)
                    print("\(isScrolling) = \(tabOffset)")
                    self.tabOffset = (isScrolling ? tabOffset : self.tabOffset)
                    
                    self.maxTabs = maxTabs
                }
            }
        }
    }
}

struct PagerHelper_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Geometry Preference...
struct TabPreferenceKey: PreferenceKey{
    
    static var defaultValue: CGRect = .init()
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

// Extending View for PageLabel and PageView Modifiers....
extension View{
    
    func pageLabel()->some View{
        // Just Filling all Empty Space...
        self
            .frame(maxWidth: .infinity,alignment: .center)
    }
    
    // Modifications for SafeArea Ignoring...
    // Same For PageView...
    func pageView(ignoresSafeArea: Bool = false,edges: Edge.Set = [])->some View{
        // Just Filling all Empty Space...
        self
            .frame(width: getScreenBounds().width,alignment: .center)
            .ignoresSafeArea(ignoresSafeArea ? .container : .init(), edges: edges)
    }
    
    // Getting SCreen Bounds...
    func getScreenBounds()->CGRect{
        return UIScreen.main.bounds
    }
}

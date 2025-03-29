//
//  Home.swift
//  SafariTabBar (iOS)
//
//  Created by Balaji on 20/06/21.
//

import SwiftUI

struct Home: View {
    var proxy: GeometryProxy
    @StateObject var bottomBarModel = BottomBarViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    // Keyboard Focus State...
    @FocusState var showKeyboard : Bool
    
    var body: some View {
        
        ZStack{
            
            let bottomEdge = proxy.safeAreaInsets.bottom
            
            // Sample ScrollView...
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 15){
                    
                    ForEach(1...6,id: \.self){index in
                        
                        Image("post\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.size.width - 30, height: 250)
                            .cornerRadius(8)
                    }
                }
                .padding()
                .padding(.bottom,70)
                // Creating Offset Modifier...
                .modifier(OffsetModifier())
                .environmentObject(bottomBarModel)
            }
            // to start from 0..
            // just set Coordinate Space for scrollview..
            .coordinateSpace(name: "TabScroll")
            
            // SearchView....
            VStack{
                
                HStack{
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "book")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    Button("Cancel"){
                        // Closing Keyboard...
                        showKeyboard.toggle()
                    }
                    .foregroundColor(.primary)

                }
                // max height for Bottom bar adjustment...
                .frame(height: 40)
                // padding bottom bottom bar size...
                // 60 + extra 10 = 70....
                .padding(.bottom,70)
                
                // Now Your Extra Content...
                if showKeyboard{
                    
                    Text("Favourite's")
                        .font(.title.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .opacity(showKeyboard ? 1 : 0)
            
            // You can alos use
            // SwiftUI 3.0
            // SafeAreaView...
            // but since when the search field clicked a new page will be visible...
            // so it will not be perfect.....
            
            //BottomBar....
            BottomBar(showKeyboard: _showKeyboard,bottomEdge: bottomEdge)
            // setting object...
                .environmentObject(bottomBarModel)
                .padding(.top,50)
            // Moving down....
                .offset(y: bottomBarModel.tabState == .floating ? 0 : (bottomEdge == 0 ? 15 : bottomEdge))
                .padding(.bottom,bottomEdge == 0 ? 15 : 0)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// BottomBar...
struct BottomBar: View{
    
    @EnvironmentObject var bottomBarModel: BottomBarViewModel
    
    // NameSpace for Animation...
    @Namespace var animation
    
    @FocusState var showKeyboard : Bool
    var bottomEdge: CGFloat
    
    var body: some View{
        
        ZStack{
            
            RoundedRectangle(cornerRadius: bottomBarModel.tabState == .floating ? 12 : 0)
                .fill(.regularMaterial)
            // dark Theme...
                .colorScheme(bottomBarModel.tabState == .floating ? .dark : .light)
            
            HStack(spacing: 15){
                
                // Hiding when Expanded...
                if bottomBarModel.tabState == .floating{
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    .padding(.trailing,10)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }

                HStack{
                    
                    Image(systemName: "magnifyingglass")
                        .font(.callout)
                        .foregroundColor(.primary)
                    
                    if bottomBarModel.tabState == .floating{
                        
                        TextField("", text: $bottomBarModel.searchText)
                            .matchedGeometryEffect(id: "SearchField", in: animation)
                            .focused($showKeyboard)
                        // Keyboard Button...
                            .submitLabel(.go)
                    }
                    else{
                        Text(bottomBarModel.searchText)
                            .matchedGeometryEffect(id: "SearchField", in: animation)
                    }
                    
                    Image(systemName: "lock")
                        .symbolVariant(.fill)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .offset(y: bottomBarModel.tabState == .floating ? 0 : (bottomEdge == 0 ? 0 : -10))
                // max width when expanded...
                .frame(maxWidth: bottomBarModel.tabState == .floating ? nil : 200)
                
                if bottomBarModel.tabState == .floating{
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "square.on.square")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
            }
            .colorScheme(bottomBarModel.tabState == .floating ? .dark : .light)
            .padding(.horizontal)
        }
        .frame(height: 60)
        .padding([.horizontal],bottomBarModel.tabState == .expanded ? 0 : 15)
        // Moving View Up...
        .frame(maxHeight: .infinity, alignment: showKeyboard ? .top : .bottom)
        // when expanded go back to floating...
        .onTapGesture {
            withAnimation(.easeOut.speed(1.5)){
                bottomBarModel.tabState = .floating
            }
        }
        .animation(.easeOut, value: showKeyboard)
    }
}

// Offset Modifier...
struct OffsetModifier: ViewModifier{
    
    @EnvironmentObject var model: BottomBarViewModel
    
    func body(content: Content) -> some View {
     
        content
            .overlay(
            
                // Geometry Reader for getting offset...
                GeometryReader{proxy -> Color in
                
                let minY = proxy.frame(in: .named("TabScroll")).minY
                
                DispatchQueue.main.async {
                    
                    // Checking and toggling states...
                    
                    // DUration Offset....
                    // your Value...
                    let durationOffset: CGFloat = 35
                    
                    if minY < model.offset{
                        
                        if model.offset < 0 && -minY > (model.lastStoredOffset + durationOffset){
                            
                            withAnimation(.easeOut.speed(1.5)){
                                // updating state...
                                model.tabState = .expanded
                            }
                            
                            model.lastStoredOffset = -model.offset
                        }
                    }
                    
                    if minY > model.offset && -minY < (model.lastStoredOffset - durationOffset){
                       
                        withAnimation(.easeOut.speed(1.5)){
                            // updating state...
                            model.tabState = .floating
                        }
                        
                        // storing last Offset...
                        model.lastStoredOffset = -model.offset
                    }
                    
                    model.offset = minY
                }
                
                return Color.clear
                
                }
                
                ,alignment: .top
            )
    }
}

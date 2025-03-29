//
//  Home.swift
//  Animated_Header (iOS)
//
//  Created by Balaji on 12/02/21.
//

import SwiftUI

struct Home: View {
    
    @StateObject var headerData = HeaderViewModel()
    
    // disabling bouncung...
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        
        ZStack(alignment: .top, content: {
            
            // header View...
            
            HeaderView()
                .zIndex(1)
                .offset(y: headerData.headerOffset)
            
            // Video View...
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack(spacing: 15){
                    
                    ForEach(1...5,id: \.self){index in
                        
                        Image("thumb\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: rect.width - 30, height: 250)
                            .cornerRadius(1)
                        
                        HStack(spacing: 10){
                            
                            Image("profile")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4, content: {
                                
                                Text("New Sony Camera Unboxng And Review")
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.leading)
                                
                                Text("iJustine . 4 hours ago")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            })
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom,15)
                    }
                }
                .padding(.top,75)
                .overlay(
                
                    // Geometry Reader For Getting Offset Values...
                    GeometryReader{proxy -> Color in
                        
                        let minY = proxy.frame(in: .global).minY
                        
                        DispatchQueue.main.async {
                            
                            // storing intial MinY value...
                            
                            if headerData.startMinY == 0{
                                
                                headerData.startMinY = minY
                            }
                            
                            // getting exact offset value by subtracting current from start...
                            
                            let offset = headerData.startMinY - minY
                            
                            // getting scroll direction....
                            
                            if offset > headerData.offset{

                                // if top hiding Header View....
                                
                                // same clearing bottom offset...
                                headerData.bottomScrollOffset = 0
                                
                                if headerData.topScrollOffset == 0{
                                    
                                    // Storing Intially to subtract the maxOffset...
                                    headerData.topScrollOffset = offset
                                }
                                
                                let progress = (headerData.topScrollOffset + getMaxOffset()) - offset
                                
                                // all conditions were going to use ternary operator
                                // because if we use if else while swiping fast it ignore some conditions....
                                
                                let offsetCondition = (headerData.topScrollOffset + getMaxOffset()) >= getMaxOffset() && getMaxOffset() - progress <= getMaxOffset()
                                
                                let headerOffset = offsetCondition ? -(getMaxOffset() - progress) : -getMaxOffset()
                                
                                headerData.headerOffset = headerOffset
                            }
                            
                            if offset < headerData.offset{

                                // if bottom revelaing header view....
                                // clearing topscrollvalue and setting botttom...
                                
                                headerData.topScrollOffset = 0
                                
                                if headerData.bottomScrollOffset == 0{
                                    
                                    headerData.bottomScrollOffset = offset
                                }
                                
                                // Moving if little bit of screen is swiped down...
                                // for eg 40 offset...
                                
                                withAnimation(.easeOut(duration: 0.2)){
                                    
                                    let headerOffset = headerData.headerOffset
                                    
                                    let conditions = headerData.bottomScrollOffset > offset + 40
                                    
                                    headerData.headerOffset = conditions ? 0 : (headerOffset != -getMaxOffset() ? 0 : headerOffset)
                                }
                            }
                            
                            headerData.offset = offset
                        }
                        
                        return Color.clear
                    }
                    .frame(height: 0)
                    
                    ,alignment: .top
                )
            })
        })
    }
    
    // getting max Top Offset Including Top safe area...
    
    func getMaxOffset()->CGFloat{
        
        return headerData.startMinY + (edges?.top ?? 0) + 10
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// edges...
var edges = UIApplication.shared.windows.first?.safeAreaInsets
// Rect...
var rect = UIScreen.main.bounds

struct HeaderView: View {
    
    // for dark Mode Adoption...
    
    @Environment(\.colorScheme) var scheme
    
    var body: some View{
        
        HStack(spacing: 20){
            
            Image("youtube")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("YouTube")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            // Word Spacing...
                .kerning(0.5)
                .offset(x: -10)
            
            Spacer(minLength: 0)
            
            Button(action: {}, label: {
                Image(systemName: "display")
                    .font(.title2)
                    .foregroundColor(.primary)
            })
            
            Button(action: {}, label: {
                Image(systemName: "bell")
                    .font(.title2)
                    .foregroundColor(.primary)
            })
            
            Button(action: {}, label: {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundColor(.primary)
            })
            
            Button(action: {}, label: {
                
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
            })
        }
        .padding(.horizontal)
        .padding(.vertical,8)
        .background((scheme == .dark ? Color.black : Color.white).ignoresSafeArea(.all, edges: .top))
        // Divider..
        .overlay(
        
            Divider()
            ,alignment: .bottom
        )
    }
}

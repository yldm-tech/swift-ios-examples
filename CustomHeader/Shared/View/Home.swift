//
//  Home.swift
//  Home
//
//  Created by Balaji on 08/09/21.
//

import SwiftUI

struct Home: View {
    
    // Offset...
    @State var offset: CGFloat = 0
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            // Top Nav Bar...
            ZStack{
                
                // Image issue in swiftui not allowing scroll when its fill...
                
                // Overcome...
                Image("Pic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getScreenBound().width, height: 300,alignment: .bottom)
                    .clipShape(
                    
                        CustomCorner(corners: [.bottomLeft], radius: getCornerRadius())
                    )
                // hiding image...
                    .opacity(1 + getProgress())
                
                CustomCorner(corners: [.bottomLeft], radius: getCornerRadius())
                    .fill(.ultraThinMaterial)
                
                
                let progress = -getProgress() < 0.4 ? getProgress() : -0.4
                // Image...
                VStack(alignment: .leading, spacing: 15) {
                    
                    Image("justine")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    // scaling down image .....
                        .scaleEffect(1 + progress * 1.3,anchor: .bottomLeading)
                    
                    Text("iJustine")
                        .font(.title.bold())
                        .foregroundColor(.primary)
                        .scaleEffect(1 + progress,anchor: .topTrailing)
                        .offset(x: progress * -40,y: progress * 130)
                }
                .padding(15)
                .padding(.bottom,30)
                // stopping view at bottom...
                // max Progress = 0.4
                // 0.4* 200 = 80
                // topbar height = 70
                // 10 = padding....
                .offset(y: progress * -200)
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottomLeading)
            }
            .frame(height: 350)
            // Moving up....
            .offset(y: getOffset())
            .zIndex(1)
            
            ScrollRefreshable(title: "Pull to Refresh", tintColor: .primary) {
                
                VStack(spacing: 15){
                    
                    ForEach(1...6,id: \.self){index in
                        
                        // Post Image...
                        Image("post\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: getScreenBound().width - 30, height: 250)
                            .cornerRadius(15)
                    }
                }
                .padding()
                .padding(.top,350)
                // eliminating top Edge...
                .padding(.top,-getSafeArea().top)
                .modifier(OffsetModifier(offset: $offset))
                
            } onRefresh: {
                
                // Simply waiting for two secs...
                await Task.sleep(2_000_000_000)
            }

        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    // Preview issue....
    func getOffset()->CGFloat{
        
        // stopping at when navbar size at 70....
        
        // reducing top edge...
        // since we ignored that edge...
        let checkSize = -offset < (280 - getSafeArea().top) ? offset : -(280 - getSafeArea().top)
        
        return offset < 0 ? checkSize : 0
    }
    
    // progress...
    func getProgress()->CGFloat{
        
        let topheight = (280 - getSafeArea().top)
        let progress = getOffset() / topheight
        
        return progress
    }
    
    // Corner Radius...
    func getCornerRadius()->CGFloat{
        
        let radius = getProgress() * 45
        
        // reducing to 0 when scrolling...
        return 45 + radius
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}

// Extending view to get screen size and safe area insect...
extension View{
    
    func getScreenBound()->CGRect{
        return UIScreen.main.bounds
    }
    
    func getSafeArea()->UIEdgeInsets{
        
        let null = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return null
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return null
        }
        
        return safeArea
    }
}

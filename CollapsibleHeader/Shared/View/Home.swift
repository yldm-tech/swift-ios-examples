//
//  Home.swift
//  Home
//
//  Created by Balaji on 27/07/21.
//

import SwiftUI

struct Home: View {
    
    // Max Height...
    let maxHeight = UIScreen.main.bounds.height < 750 ? (UIScreen.main.bounds.height / 1.9) : (UIScreen.main.bounds.height / 2.3)
    
    var topEdge: CGFloat
    
    // Offset...
    @State var offset: CGFloat = 0
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 15){
                
                // Top Nav View...
                GeometryReader{proxy in
                    
                    TopBar(topEdge: topEdge,offset: $offset,maxHeight: maxHeight)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    // Sticky Effect...
                    .frame(height: getHeaderHeight(),alignment: .bottom)
                    .background(
                        Color("TopBar")
                        ,in: CustomCorner(corners: [.bottomRight], radius: getCornerRadius())
                    )
                    .overlay(
                    
                        TopNavBar(offset: $offset, maxHeight: maxHeight, topEdge: topEdge)
                            .padding(.horizontal)
                        // MaxHeight..
                            .frame(height: 80)
                            .foregroundColor(.white)
                            .padding(.top,topEdge)
                        
                        ,alignment: .top
                    )
                }
                .frame(height: maxHeight)
                // Fixing at top...
                .offset(y: -offset)
                .zIndex(1)
                
                // Sample Messages...
                VStack(spacing: 15){
                    
                    ForEach(allMessages){message in
                        
                        // Card View...
                        MessageCardView(message: message)
                    }
                }
                .padding()
                .zIndex(0)
            }
            .modifier(OffsetModifier(offset: $offset))
        }
        // setting coordinate space...
        .coordinateSpace(name: "SCROLL")
    }
    
    func getHeaderHeight()->CGFloat{
        
        let topHeight = maxHeight + offset
        
        // 80 is the constant top Nav bar height...
        // since we included top safe area so we also need to include that too...
        
        return topHeight > (80 + topEdge) ? topHeight : (80 + topEdge)
    }
    
    func getCornerRadius()->CGFloat{
        
        let progress = -offset / (maxHeight - (80 + topEdge))
        
        let value = 1 - progress
        
        let radius = value * 50
        
        return offset < 0 ? radius : 50
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TopNavBar: View{
    
    @Binding var offset: CGFloat
    var maxHeight: CGFloat
    var topEdge: CGFloat
    
    var body: some View{
        
        // Top Nav View...
        HStack(spacing: 15){
            
            Button {
                
            } label: {
                Image(systemName: "xmark")
                    .font(.body.bold())
            }
            
            Image("Pic")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 35, height: 35)
                .clipShape(Circle())
                .opacity(topBarTitleOpacity())
            
            Text("iJustine")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .opacity(topBarTitleOpacity())
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "line.3.horizontal.decrease")
                    .font(.body.bold())
            }

        }
    }
    
    func topBarTitleOpacity()->CGFloat{
        
        // to start after the main content vansihed...
        // we need to eliminate 70 from offset....
        // to get starter....
        let progress = -(offset + 60) / (maxHeight - (80 + topEdge))
                
        return progress
    }
}

struct TopBar: View{
    
    var topEdge: CGFloat
    @Binding var offset: CGFloat
    var maxHeight: CGFloat
    
    var body: some View{
        
        VStack(alignment: .leading, spacing: 15) {
            
            
            Image("Pic")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            
            Text("iJustine")
                .font(.largeTitle.bold())
            
            
            Text("Justine Ezarik is an American YouTuber, host, author, She is best known as iJustine")
                .fontWeight(.semibold)
                .foregroundColor(Color.white.opacity(0.8))
                .lineLimit(2)
        }
        .padding()
        .padding(.bottom)
        .opacity(getOpacity())
    }
    
    // Calculation Opacity...
    func getOpacity()->CGFloat{
        
        // 70 = Some random amount of time to visible on scroll...
        let progress = -offset / 70
        
        let opacity = 1 - progress
        
        return offset < 0 ? opacity : 1
    }
}

struct MessageCardView: View{
    
    var message: Message
    
    var body: some View{
        
        HStack(spacing: 15){
            
            Circle()
                .fill(message.tintColor)
                .frame(width: 50, height: 50)
                .opacity(0.8)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(message.userName)
                    .fontWeight(.bold)
                
                Text(message.message)
                    .foregroundColor(.secondary)
            }
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity,alignment: .leading)
        }
    }
}

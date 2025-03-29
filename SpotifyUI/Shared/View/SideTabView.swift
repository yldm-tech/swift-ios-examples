//
//  SideTabView.swift
//  SpotifyUI (iOS)
//
//  Created by Balaji on 17/04/21.
//

import SwiftUI

struct SideTabView: View {
    // Storing Current Tab..
    @State var selectedTab = "house.fill"
    
    // Volume...
    @State var volume: CGFloat = 0.4
    
    // Hide Side Tab Bar...
    @State var showSideBar = false
    var body: some View {
        // Side Tab Bar
        // Optimizing for smaller size iphone...
        VStack{
            
            Image("spotify")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 45, height: 45)
                .padding(.top)
            
            VStack{
                
                TabButton(image: "house.fill", selectedTab: $selectedTab)
                
                TabButton(image: "safari.fill", selectedTab: $selectedTab)
                
                TabButton(image: "mic.fill", selectedTab: $selectedTab)
                
                TabButton(image: "clock.fill", selectedTab: $selectedTab)
            }
            // setting the tabs for half of the height so that remaining elements will get space....
            .frame(height: getRect().height / 2.3)
            .padding(.top)
            
            Spacer(minLength: getRect().height < 750 ? 30 : 50)
            
            Button(action: {
                // checking and increasing volume...
                volume = volume + 0.1 < 1.0 ? volume + 0.1 : 1
            }, label: {
                Image(systemName: "speaker.wave.2.fill")
                    .font(.title2)
                    .foregroundColor(.white)
            })
            
            // Custom Volume Progress View...
            GeometryReader{proxy in
                
                // extracing progress bar height and based on that getting progress value...
                let height = proxy.frame(in: .global).height
                let progress = height * volume
                
                ZStack(alignment: .bottom){
                    
                    Capsule()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 4)
                    
                    Capsule()
                        .fill(Color.white)
                        .frame(width: 4,height: progress)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .padding(.vertical,getRect().height < 750 ? 15 : 20)
            
            Button(action: {
                // checking and decreasing volume...
                volume = volume - 0.1 > 0 ? volume - 0.1 : 0
            }, label: {
                Image(systemName: "speaker.wave.1.fill")
                    .font(.title2)
                    .foregroundColor(.white)
            })
            
            Button(action: {
                withAnimation(.easeIn){
                    showSideBar.toggle()
                }
            }, label: {
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .foregroundColor(.white)
                    // rotating...
                    .rotationEffect(.init(degrees: showSideBar ? -180 : 0))
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            })
            .padding(.top,getRect().height < 750 ? 10 : 30)
            .padding(.bottom,getSafeArea().bottom == 0 ? 15 : 0)
            .offset(x: showSideBar ? 0 : 100)
        }
        // Max Side tab Bar Width...
        .frame(width: 80)
        .background(Color.black.ignoresSafeArea())
        .offset(x: showSideBar ? 0 : -100)
        // reclaiming the spacing by using negative spacing...
        // if you want to move the view along with tab bar...
        .padding(.trailing,showSideBar ? 0 : -100)
        // changing the stack position
        // so that the side tab bar will be on top..
        .zIndex(1)
    }
}

struct SideTabView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// Tab Button...
struct TabButton: View {
    
    var image: String
    @Binding var selectedTab: String
    
    var body: some View{
        
        Button(action: {
            withAnimation{selectedTab = image}
        }, label: {
            Image(systemName: image)
                .font(.title)
                .foregroundColor(selectedTab == image ? .white : Color.gray.opacity(0.6))
                .frame(maxHeight: .infinity)
        })
    }
}

// Extending View to get Screen Size...
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
    // getting safe area...
    func getSafeArea()->UIEdgeInsets{
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


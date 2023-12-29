//
//  BaseView.swift
//  BaseView
//
//  Created by Balaji on 15/09/21.
//

import SwiftUI

struct BaseView: View {
    @State var currentTab = "house.fill"
    
    // Hiding native tab bar...
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    // Curve Axis Value....
    @State var curveAxis: CGFloat = 0
    
    var body: some View {
        
        VStack(spacing: 0){
            
            // Tab View...
            TabView(selection: $currentTab){
                
                // Tab Views.....
                Home()
                    .tag("house.fill")
                
                Text("Search")
                    .tag("magnifyingglass")
                
                Text("Account")
                    .tag("person.fill")
            }
            .clipShape(
            
                CustomTabCurve(curveAxis: curveAxis)
            )
            .padding(.bottom,-90)
            
            HStack(spacing: 0){
                
                // Tab BUttons...
                TabButtons()
            }
            .frame(height: 50)
            .padding(.horizontal,35)
            .padding(.bottom,getSafeArea().bottom == 0 ? 10 : 0)
        }
        .background(Color("Brown"))
        .ignoresSafeArea(.container, edges: .top)
    }
    
    @ViewBuilder
    func TabButtons()->some View{
        
        ForEach(["house.fill","magnifyingglass","person.fill"],id: \.self){image in
            
            GeometryReader{proxy in
                
                // Since we need current postion for curve...
                
                Button {
                    withAnimation{
                        currentTab = image
                        // updating curve axis...
                        curveAxis = proxy.frame(in: .global).midX
                    }
                } label: {
                    
                    Image(systemName: image)
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 45,height: 45)
                        .background(
                        
                            Circle()
                                .fill(Color("Brown"))
                        )
                        .offset(y: currentTab == image ? -25 : 0)
                }
                .frame(maxWidth: .infinity,alignment: .center)
                // intial update...
                .onAppear {
                    
                    if curveAxis == 0 && image == "house.fill"{
                        curveAxis = proxy.frame(in: .global).midX
                    }
                }

            }
            .frame(height: 40)
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}

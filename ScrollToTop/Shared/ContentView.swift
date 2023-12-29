//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 25/04/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        NavigationView{
            
            Home()
                .navigationTitle("Medium")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    @State var scrollViewOffset: CGFloat = 0
    
    // Getting Start Offset and eliminating from current offset so that we will get exact offset...
    @State var startOffset: CGFloat = 0
    
    @State var isScrollToTop = false
    
    var body: some View{
        
        // SCroll To Top Function...
        // with the help of scrollview Reader...
        
        ScrollViewReader {proxyReader in
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack(spacing: 25){
                    
                    ForEach(1...30,id: \.self){index in
                        
                        // Sample Row View...
                        HStack(spacing: 15){
                            
                            Circle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 60, height: 60)
                            
                            VStack(alignment: .leading, spacing: 8, content: {
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(height: 22)
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(height: 22)
                                    .padding(.trailing,100)
                            })
                        }
                    }
                }
                .padding()
                // setting ID
                // so that it can scroll to that position...
                .id("SCROLL_TO_TOP")
                // getting scrollView Offset...
                .overlay(
                
                    // Using Geometry Reader to get SCrollView Offset...
                    GeometryReader{proxy -> Color in
                        
                        DispatchQueue.main.async {
                            
                            if startOffset == 0{
                                self.startOffset = proxy.frame(in: .global).minY
                            }
                            
                            let offset = proxy.frame(in: .global).minY
                            
                            self.scrollViewOffset = offset - startOffset
                            
                            print(self.scrollViewOffset)
                        }
                        
                        return Color.clear
                    }
                    .frame(width: 0, height: 0)
                    
                    ,alignment: .top
                )
            })
            // if offset goes less than 450 then showing floating action button at bottom...
            .overlay(
            
                Button(action: {
                    
                    // scroll to top with animation...

                    withAnimation(Animation.linear(duration: 0.3)){
                        isScrollToTop = true
                        proxyReader.scrollTo("SCROLL_TO_TOP", anchor: .top)
                    }

                    // To Avoid Simentaneous Multiple Taps....
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        
                        isScrollToTop = false
                    }
                    
                }, label: {
                    
                    Image(systemName: "arrow.up")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("red"))
                        .clipShape(Circle())
                        // shadow...
                        .shadow(color: Color.black.opacity(0.09), radius: 5, x: 5, y: 5)
                })
                .buttonStyle(BorderlessButtonStyle())
                .padding(.trailing)
                .padding(.bottom,getSafeArea().bottom == 0 ? 12 : 0)
                .opacity(-scrollViewOffset > 450 ? 1 : 0)
                .animation(.easeInOut)
                .disabled(isScrollToTop)
                
                // fixing at bottom left...
                ,alignment: .bottomTrailing
            )
        }
    }
}

// extending view to get saferarea...
extension View{
    
    func getSafeArea()->UIEdgeInsets{
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


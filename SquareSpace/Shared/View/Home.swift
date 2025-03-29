//
//  Home.swift
//  SquareSpace (iOS)
//
//  Created by Balaji on 25/01/21.
//

import SwiftUI

struct Home: View {
    
    @State var firstMinY: CGFloat = 0
    
    // Stoping Bounces On SCrollView...
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    @State var minY: CGFloat = 0
    @State var lastMinY: CGFloat = 0
    @State var scale : CGFloat = 0
    
    var body: some View {
        
        VStack(spacing: 0){
            
            HeaderView()
            
            ScrollView{
                
                // Top Sticky View...
                StickyView(firstMinY: $firstMinY,minY: $minY,lastMinY: $lastMinY,scale: $scale)
                
                VStack(alignment: .leading, spacing: 15, content: {
                    
                    ForEach(subTitles,id: \.self){title in
                        
                        Section(header: Text(title)
                                    .font(.title)
                                    .fontWeight(.bold)) {
                            
                            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
                        }
                    }
                })
                .padding()
                // since were moving view up...
                .padding(.bottom,lastMinY)
                .background(Color.white)
                .offset(y: scale > 0.4 ? minY : lastMinY)
                .opacity(scale != 0.4 ? 1 : 0)
            }
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color("Color").ignoresSafeArea(.all, edges: .all))
    }
}

let subTitles = ["Award Winning\nWeb Designs","Flexible Portfolios","Blogging Tools","Built-in SEO Tools","Analytics"]

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// Extending View To Get Screen Rect...

extension View{
    
    func getScreen()->CGRect{
        
        return UIScreen.main.bounds
    }
}

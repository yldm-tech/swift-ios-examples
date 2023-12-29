//
//  Home.swift
//  Home
//
//  Created by Balaji on 21/07/21.
//

import SwiftUI

struct Home: View {
    
    @State var show = false
    
    // Storing Current Day...
    @State var currentDay : Int = 1
    
    var body: some View {
        
        NavigationView{
            
            // Sample List...
            List{
                Section(header: Text("Tutorial's")) {
                    
                    ForEach(1...15,id: \.self){index in
                        
                        Button {
                            currentDay = index
                            withAnimation{
                                show.toggle()
                            }
                        } label: {
                            Text("Day \(index) of SwiftUI")
                        }
                        .foregroundColor(.primary)

                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Full Swipe Pop")
        }
        .fullSwipePop(show: $show) {
            
            List{
                
                Section(header: Text("Day \(currentDay)")) {
                    
                    ForEach(1...30,id: \.self){index in
                        
                        Text("Course \(index)")
                    }
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//
//  Home.swift
//  CustomContentMenu (iOS)
//
//  Created by Balaji on 01/07/21.
//

import SwiftUI

struct Home: View {
    
    @State var onEnded = false
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                
                CustomContextMenu {
                    
                    // Content....
                    Label {
                        Text("Unlock Me")
                    } icon: {
                        Image(systemName: "lock.fill")
                    }
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.vertical,12)
                    .padding(.horizontal,20)
                    .background(.purple)
                    .cornerRadius(8)

                    
                } preview: {
                    
                    // Preview.....
                    Image("Pic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                } actions: {
                    
                    // Your Actions in Menu....
                    
                    // Actions...
                    let like = UIAction(title: "Like Me",image: UIImage(systemName: "suit.heart.fill")) { _ in
                        print("like")
                    }
                    
                    let share = UIAction(title: "Share",image: UIImage(systemName: "square.and.arrow.up.fill")) { _ in
                        print("share")
                    }
                    
                    return UIMenu(title: "",children: [like,share])
                } onEnd: {
                    
                    print("Ended")
                    withAnimation{
                        onEnded.toggle()
                    }
                }
                
                // Your View when its expanded....
                if onEnded{
                    
                    // for getting size
                    GeometryReader{proxy in
                        
                        let size = proxy.size
                        
                        Image("Pic")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .cornerRadius(1)
                    }
                    .ignoresSafeArea(.all, edges: .bottom)
                    // removing opacity animation...
                    .transition(.identity)
                    // Nav Bar Button For CLosing...
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            
                            Button("Close"){
                                withAnimation{
                                    onEnded.toggle()
                                }
                            }
                        }
                    }
                }

            }
            .navigationTitle(onEnded ? "Unlocked" : "Custom Context Menu")
            // changing nav bar style...
            .navigationBarTitleDisplayMode(onEnded ? .inline : .large)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

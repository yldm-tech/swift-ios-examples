//
//  DirectView.swift
//  Instagram_DM_Swipe (iOS)
//
//  Created by Balaji on 06/02/21.
//

import SwiftUI

struct DirectView: View {
    
    @Binding var currentTab: String
    var edges: EdgeInsets
    @State var search = ""
    
    var body: some View {
        
        VStack{
            
            HStack(spacing: 15){
                
                Button(action: {
                    currentTab = "Home"
                }, label: {
                    
                    HStack{
                        
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24, weight: .bold))
                        
                        Text("Direct")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                })
                
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "video")
                        .font(.title)
                })
                
                Button(action: {}, label: {
                    Image(systemName: "square.and.pencil")
                        .font(.title)
                })
            }
            .foregroundColor(.primary)
            .padding()
            
            ScrollView{
                
                VStack(spacing: 15){
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search", text: $search)
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(Color.primary.opacity(0.06))
                    .cornerRadius(12)
                    
                    ForEach(posts){post in
                        
                        HStack(spacing: 15){
                            
                            Image(post.profile)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 55, height: 55)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 5, content: {
                                
                                Text(post.user)
                                    .fontWeight(.semibold)
                                
                                Text("Active \(post.time)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            })
                            
                            Spacer()
                            
                            Button(action: {}, label: {
                                Image(systemName: "camera")
                                    .font(.title)
                            })
                            .foregroundColor(.gray)
                        }
                        .padding(.top,8)
                    }
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top,edges.top)
    }
}

struct DirectView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

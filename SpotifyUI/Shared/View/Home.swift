//
//  Home.swift
//  SpotifyUI (iOS)
//
//  Created by Balaji on 17/04/21.
//

import SwiftUI

struct Home: View {
    
    // Search Text...
    @State var searchText = ""
    
    var body: some View {
        
        HStack(spacing: 0){
            
            SideTabView()
            
            // Main Content...
            ScrollView(showsIndicators: false, content: {
                
                VStack(spacing: 15){
                    
                    HStack(spacing: 15){
                        
                        HStack(spacing: 15){
                            
                            Circle()
                                .stroke(Color.white,lineWidth: 4)
                                .frame(width: 25, height: 25)
                            
                            TextField("Search...", text: $searchText)
                        }
                        .padding(.vertical,10)
                        .padding(.horizontal)
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(8)
                        
                        Button(action: {}, label: {
                            Image("profile")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 45, height: 45)
                                .cornerRadius(10)
                        })
                    }
                    
                    Text("Recently Played")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top,30)
                    
                    // Carousel List...
                    TabView{
                        
                        ForEach(recentlyPlayed){item in
                            
                            GeometryReader{proxy in
                                
                                ZStack(alignment: .bottomLeading){
                                    
                                    Image(item.album_cover)
                                        .resizable()
                                        // if youre using fill then u must specify the width...
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: proxy.frame(in: .global).width)
                                        .cornerRadius(20)
                                    // dark shading at bottom so that the data will be visible...
                                        .overlay(
                                        
                                            LinearGradient(gradient: .init(colors: [Color.clear,Color.clear,Color.black]), startPoint: .top, endPoint: .bottom)
                                                .cornerRadius(20)
                                        )
                                        
                                    
                                    HStack(spacing: 15){
                                        
                                        Button(action: {}, label: {
                                            
                                            // Play Button..
                                            Image(systemName: "play.fill")
                                                .font(.title)
                                                .foregroundColor(.white)
                                                .padding(20)
                                                .background(Color("logoColor"))
                                                .clipShape(Circle())
                                        })
                                        
                                        VStack(alignment: .leading, spacing: 5, content: {
                                            
                                            Text(item.album_name)
                                                .font(.title2)
                                                .fontWeight(.heavy)
                                                .foregroundColor(.white)
                                            
                                            Text(item.album_author)
                                                .font(.none)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                        })
                                    }
                                    .padding()
                                }
                            }
                            .padding(.horizontal)
                            .frame(height: 350)
                        }
                    }
                    // max Frame...
                    .frame(height: 350)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .padding(.top,20)
                    
                    Text("Genres")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top,30)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 15), count: 3), spacing: 20, content: {
   
                        // List Of Genres...
                        ForEach(generes,id: \.self){genre in
                            
                            Text(genre)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.vertical,8)
                                .frame(maxWidth: .infinity)
                                .background(Color.white.opacity(0.06))
                                .clipShape(Capsule())
                        }
                    })
                    .padding(.top,20)
                    
                    Text("Liked Songs")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top,30)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 10), count: 2), spacing: 10, content: {

                        // Liked Songs...
                        ForEach(likedSongs.indices,id: \.self){index in
                            
                            GeometryReader{proxy in
                                
                                Image(likedSongs[index].album_cover)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: proxy.frame(in: .global).width, height: 150)
                                    // based on index number were changing the corner style...
                                    .clipShape(CustomCorners(corners: index % 2 == 0 ? [.topLeft,.bottomLeft] : [.topRight,.bottomRight], radius: 15))
                            }
                            .frame(height: 150)
                        }
                    })
                    .padding(.horizontal)
                    .padding(.top,20)
                }
                .padding()
                .frame(maxWidth: .infinity)
            })
            
        }
        .background(Color("bg").ignoresSafeArea())
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// Custom Corner for Single Side Corner Image...

struct CustomCorners: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

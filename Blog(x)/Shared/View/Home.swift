//
//  Home.swift
//  Home
//
//  Created by Balaji on 10/08/21.
//

import SwiftUI

struct Home: View {
    @StateObject var blogData = BlogViewModel()
    
    // Color Based on ColorScheme...
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        
        VStack{
            
            if let posts = blogData.posts{
                
                // No Posts...
                if posts.isEmpty{
                    
                    (
                        Text(Image(systemName: "rectangle.and.pencil.and.ellipsis"))
                         +
                        
                        Text("Start Writing Blog")
                    )
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
                else{
                    
                    List(posts){post in
                        
                        // CardView...
                        CardView(post: post)
                        // Swipe to delete...
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                
                                Button(role: .destructive) {
                                    blogData.deletePost(post: post)
                                } label: {
                                    
                                    Image(systemName: "trash")
                                }

                            }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            else{

                ProgressView()
            }
        }
        .navigationTitle("My Blog")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
        
            // FAB Button...
            Button(action: {
                blogData.createPost.toggle()
            }, label: {
                
                Image(systemName: "plus")
                    .font(.title2.bold())
                    .foregroundColor(scheme == .dark ? Color.black : Color.white)
                    .padding()
                    .background(.primary,in: Circle())
            })
            .padding()
            .foregroundStyle(.primary)
            
            ,alignment: .bottomTrailing
        )
        
        // fetching Blog Posts...
        .task {
            await blogData.fetchPosts()
        }
        .fullScreenCover(isPresented: $blogData.createPost, content: {
            
            // Create Post View....
            CreatePost()
                .overlay(
                
                    ZStack{
                        
                        Color.primary.opacity(0.25)
                            .ignoresSafeArea()
                        
                        ProgressView()
                            .frame(width: 80, height: 80)
                            .background(scheme == .dark ? .black : .white,in: RoundedRectangle(cornerRadius: 15))
                    }
                    .opacity(blogData.isWriting ? 1 : 0)
                )
                .environmentObject(blogData)
        })
        .alert(blogData.alertMsg, isPresented: $blogData.showAlert) {
            
        }
    }
    
    @ViewBuilder
    func CardView(post: Post)->some View{
        
        // Detail View...
        NavigationLink {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    
                    Text("Written By: \(post.author)")
                        .foregroundColor(.gray)
                    
                    Text("Written By: \(            post.date.dateValue().formatted(date: .numeric, time: .shortened))")
                        .foregroundColor(.gray)
                    
                    ForEach(post.postContent){content in
                        
                        if content.type == .Image{
                            WebImage(url: content.value)
                        }
                        else{
                            Text(content.value)
                                .font(.system(size: getFontSize(type: content.type)))
                                .lineSpacing(10)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(post.title)
            
        } label: {
            
            VStack(alignment: .leading, spacing: 12) {
                
                Text(post.title)
                    .fontWeight(.bold)
                
                Text("Written By: \(post.author)")
                    .font(.callout)
                    .foregroundColor(.gray)
                
                Text("Written By: \(            post.date.dateValue().formatted(date: .numeric, time: .shortened))")
                    .font(.caption.bold())
                    .foregroundColor(.gray)
            }
        }

    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

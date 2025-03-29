//
//  BlogViewModel.swift
//  BlogViewModel
//
//  Created by Balaji on 10/08/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class BlogViewModel: ObservableObject{
    
    // Posts...
    @Published var posts: [Post]?
    
    // errors...
    @Published var alertMsg = ""
    @Published var showAlert = false
    
    // New Post...
    @Published var createPost = false
    @Published var isWriting = false
    
    // Async Await Method...
    func fetchPosts()async{
        
        if posts != nil{
            return
        }
        
        do{
            
            let db = Firestore.firestore().collection("Blog")
            
            let posts = try await db.getDocuments()
            
            // Converting to our Model...
            self.posts = posts.documents.compactMap({ post in
                
                return try? post.data(as: Post.self)
            })
        }
        catch{
            alertMsg = error.localizedDescription
            showAlert.toggle()
        }
    }
    
    func deletePost(post: Post){
     
        guard let _ = posts else{return}
        
        let index = posts?.firstIndex(where: { currentPost in
            return currentPost.id == post.id
        }) ?? 0
        
        // deleting Post...
        Firestore.firestore().collection("Blog").document(post.id ?? "").delete()
        
        withAnimation{posts?.remove(at: index)}
    }
    
    func writePost(content: [PostContent],author: String,postTitle: String){
        
        do{
            
            // Loading Animation...
            withAnimation{
                isWriting = true
            }
            
            // Storing to DB...
            let post = Post(title: postTitle, date: Timestamp(date: Date()), author: author, postContent: content)
            
            let _ = try Firestore.firestore().collection("Blog").document().setData(from: post, completion: { err in
                if let _ = err{
                    return
                }
                
                withAnimation{[self] in
                    // adding to posts...
                    posts?.append(post)
                    isWriting = false
                    // Closing Post View...
                    createPost = false
                }
            })
            
            
        }
        catch{
            print(error.localizedDescription)
        }
    }
}

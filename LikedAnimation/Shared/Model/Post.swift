//
//  Post.swift
//  Post
//
//  Created by Balaji on 04/09/21.
//

import SwiftUI

// Post Model...
struct Post: Identifiable{
    var id = UUID().uuidString
    var imageName: String
    var isLiked: Bool = false
}

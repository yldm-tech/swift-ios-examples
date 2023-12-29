//
//  Post.swift
//  Post
//
//  Created by Balaji on 24/08/21.
//

import SwiftUI

struct Post: Identifiable,Hashable {
    var id = UUID().uuidString
    var imageURL: String
}


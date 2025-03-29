//
//  Post.swift
//  StaggeredGrid (iOS)
//
//  Created by Balaji on 15/07/21.
//

import SwiftUI

struct Post: Identifiable,Hashable {
    var id = UUID().uuidString
    var imageURL: String
}

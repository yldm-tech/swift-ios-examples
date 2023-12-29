//
//  StoryBundle.swift
//  StoryBundle
//
//  Created by Balaji on 29/07/21.
//

import SwiftUI

// StoryBundle Model And Sample Stories...
// StoryBundle -> Number of stories for each Users....
struct StoryBundle: Identifiable,Hashable{
    var id = UUID().uuidString
    var profileName: String
    var profileImage: String
    var isSeen: Bool = false
    var stories: [Story]
}

struct Story: Identifiable,Hashable{
    var id = UUID().uuidString
    var imageURL: String
}

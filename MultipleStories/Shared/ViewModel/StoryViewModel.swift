//
//  StoryViewModel.swift
//  StoryViewModel
//
//  Created by Balaji on 29/07/21.
//

import SwiftUI

class StoryViewModel: ObservableObject{
    
    // List of Stories...
    @Published var stories : [StoryBundle] = [
    
        StoryBundle(profileName: "iJustine", profileImage: "Pic1", stories: [
        
            Story(imageURL: "post1"),
            Story(imageURL: "post2"),
            Story(imageURL: "post3"),
        ]),
        
        StoryBundle(profileName: "Jenna Ezarik", profileImage: "Pic2", stories: [
        
            Story(imageURL: "post4"),
            Story(imageURL: "post5"),
        ])
    ]
    
    // Properties...
    @Published var showStory: Bool = false
    // Will Be unique Story Bundle ID....
    @Published var currentStory: String = ""
}

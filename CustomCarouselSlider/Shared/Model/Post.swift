//
//  Post.swift
//  Post
//
//  Created by Balaji on 17/09/21.
//

import SwiftUI

// Post Model and Sample Data...
struct Post: Identifiable{
    var id = UUID().uuidString
    var postImage: String
    var title: String
    var description: String
    var starRating: Int
}

var posts = [

    Post(postImage: "post1",title: "Black Widow",description: "Natasha Romanoff, aka Black Widow, confronts the darker parts of her ledger when a dangerous conspiracy with ties to her past arises.",starRating: 4),
    
    Post(postImage: "post2",title: "Loki",description: "Loki, the God of Mischief, steps out of his brother's shadow to embark on an adventure that takes place after the events of Avengers: Endgame",starRating: 5),
    
    Post(postImage: "post3",title: "Loki",description: "Living idealized suburban lives, super-powered beings Wanda and Vision begin to suspect that everything is not as it seems",starRating: 4),
    
    Post(postImage: "post4",title: "Falcon And the Winter Soldier",description: "Falcon and the Winter Soldier are a mismatched duo who team up for a global adventure that will test their survival skills -- as well as their patience.",starRating: 5),
    
    Post(postImage: "post5",title: "Mulan",description: "A girl disguises as a male warrior and joins the imperial army in order to prevent her sick father from being forced to enlist as he has no male heir.",starRating: 3),
    
    Post(postImage: "post6",title: "Avengers Endgame",description: "After Thanos, an intergalactic warlord, disintegrates half of the universe, the Avengers must reunite and assemble again to reinvigorate their trounced allies and restore balance.",starRating: 5),
]

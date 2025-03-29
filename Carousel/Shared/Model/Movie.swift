//
//  Movie.swift
//  Carousel (iOS)
//
//  Created by Balaji on 10/07/21.
//

import SwiftUI

// Data Model And Sample Data....
struct Movie: Identifiable{
    var id = UUID().uuidString
    var movieName: String
    var artwork: String
}

var movies = [

    Movie(movieName: "Black Widow", artwork: "post1"),
    Movie(movieName: "Loki", artwork: "post2"),
    Movie(movieName: "Wanda Vision", artwork: "post3"),
    Movie(movieName: "The Falcon and the Winter Soldier", artwork: "post4"),
    Movie(movieName: "Mulan", artwork: "post5"),
    Movie(movieName: "Endgame", artwork: "post6"),
    Movie(movieName: "Age of Ultron", artwork: "post7"),
]

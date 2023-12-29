//
//  Song.swift
//  SpotifyUI (iOS)
//
//  Created by Balaji on 17/04/21.
//

import SwiftUI

// Song Model And Sample Data....

struct Song: Identifiable{

    var id = UUID().uuidString
    var album_name : String
    var album_author : String
    var album_cover : String
}

var recentlyPlayed = [

    Song(album_name: "Bad Blood", album_author: "Taylor Swift", album_cover: "p2"),
    Song(album_name: "Believer", album_author: "Kurt Hugo Schneider", album_cover: "p3"),
    Song(album_name: "Let Me Love You", album_author: "DJ Snake", album_cover: "p4"),
    Song(album_name: "Shape Of You", album_author: "Ed Sherran", album_cover: "p5"),
]

var likedSongs = [

    //Song(album_name: "Let Her Go", album_author: "Passenger", album_cover: "p1"),
    Song(album_name: "Blank Space", album_author: "Taylor Swift", album_cover: "p6"),
    Song(album_name: "Havana", album_author: "Camila Cabello", album_cover: "p7"),
    Song(album_name: "Red", album_author: "Taylor Swift", album_cover: "p8"),
    Song(album_name: "I Like It", album_author: "J Balvin", album_cover: "p9"),
    Song(album_name: "Lover", album_author: "Taylor Swift", album_cover: "p10"),
    Song(album_name: "7/27 Harmony", album_author: "Camila Cabello", album_cover: "p11"),
    Song(album_name: "Joanne", album_author: "Lady Gaga", album_cover: "p12"),
    Song(album_name: "Roar", album_author: "Kay Perry", album_cover: "p13"),
    Song(album_name: "My Church", album_author: "Maren Morris", album_cover: "p14"),
    Song(album_name: "Part Of Me", album_author: "Katy Perry", album_cover: "p15"),
]

var generes = ["Classic","Hip-Hop","Electronic","Chilout","Dark","Calm","Ambient","Dance"]

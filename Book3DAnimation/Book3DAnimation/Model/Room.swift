//
//  BookRoom.swift
//  Book3DAnimation
//
//  Created by Balaji on 19/07/23.
//

import SwiftUI

/// Room Model
struct Room: Identifiable {
    var id: UUID = .init()
    var image: String
    var host: Host
    var showContent: Bool = false
    var rotation: CGFloat = 0
    var toggle: Bool = false
    
    struct Host: Identifiable {
        var id: UUID = .init()
        var profileImage: String
        var name: String
        var rating: String
        var reviews: String
    }
}

/// Sample Rooms
var sampleRooms: [Room] = [
    .init(image: "Pic 1", host: .init(profileImage: "Profile 1", name: "iJustine", rating: "200", reviews: "4.9")),
    .init(image: "Pic 2", host: .init(profileImage: "Profile 2", name: "Becky", rating: "98", reviews: "4.2")),
    .init(image: "Pic 3", host: .init(profileImage: "Profile 3", name: "Jenna", rating: "120", reviews: "4.7")),
    .init(image: "Pic 4", host: .init(profileImage: "Profile 4", name: "Miranda", rating: "308", reviews: "4.6")),
]

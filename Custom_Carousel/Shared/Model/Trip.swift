//
//  Trip.swift
//  Custom_Carousel (iOS)
//
//  Created by Balaji on 23/04/21.
//

import SwiftUI

// Model and sample Data...
struct Trip: Identifiable,Hashable{
    
    var id = UUID().uuidString
    var image: String
    var title: String
}

var trips = [

    Trip(image: "p2", title: "Mountain"),
    Trip(image: "p6", title: "Big Sur"),
    Trip(image: "p5", title: "High Sierra"),
    Trip(image: "p3", title: "Ocean"),
    Trip(image: "p4", title: "Hills"),
    Trip(image: "p1", title: "Village"),
]

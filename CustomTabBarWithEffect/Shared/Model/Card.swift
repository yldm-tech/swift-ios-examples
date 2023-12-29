//
//  Card.swift
//  Card
//
//  Created by Balaji on 19/07/21.
//

import SwiftUI

// Card Model And Sample Card Data....
struct Card: Identifiable,Equatable{
    var id = UUID().uuidString
    var title: String
    var image: String
    var cardColor: String
}

var cards : [Card] = [

    Card(title: "2021 Best SwiftUI Course", image: "card1",cardColor: "C2"),
    Card(title: "Full Stack Website Developemnt", image: "card2",cardColor: "C1")
]

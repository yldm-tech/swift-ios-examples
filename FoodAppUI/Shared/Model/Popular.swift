//
//  Popular.swift
//  Food App UI (iOS)
//
//  Created by Balaji on 08/04/21.
//

import SwiftUI

// Model And Sample Data...

struct Popular: Identifiable {
    
    var id = UUID().uuidString
    var title: String
    var description: String
    var image: String
    var price: String
}

var popular_Items = [

    Popular(title: "Beef Burger", description: "Cheesy Mozarella", image: "burger1", price: "6.59"),
    
    Popular(title: "Double Burger", description: "Double Beef", image: "burger2", price: "7.49"),
]


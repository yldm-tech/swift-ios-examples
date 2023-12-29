//
//  Category.swift
//  Food App UI (iOS)
//
//  Created by Balaji on 08/04/21.
//

import SwiftUI

// Model And Sample Data....

struct Category: Identifiable {
    
    var id: String = UUID().uuidString
    var image: String
    var title: String
}

var categories = [

    Category(image: "hamburger", title: "Burger"),
    Category(image: "pizza", title: "Pizza"),
    Category(image: "sandwich", title: "Sandwich"),
    Category(image: "cupcake", title: "Cupcake's")
]

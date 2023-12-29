//
//  Furniture.swift
//  Furniture
//
//  Created by Balaji on 15/09/21.
//

import SwiftUI

// Model...
struct Furniture: Identifiable{
    var id = UUID().uuidString
    var name: String
    var description: String
    var price: String
    var image: String
}


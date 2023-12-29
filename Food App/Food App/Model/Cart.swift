//
//  Cart.swift
//  Food App
//
//  Created by Balaji on 28/10/20.
//

import SwiftUI

struct Cart: Identifiable {
    
    var id = UUID().uuidString
    var item: Item
    var quantity: Int
}

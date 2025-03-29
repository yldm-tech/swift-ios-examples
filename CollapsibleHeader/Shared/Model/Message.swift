//
//  Message.swift
//  Message
//
//  Created by Balaji on 27/07/21.
//

import SwiftUI

// Message Model and Sample Data...
struct Message: Identifiable{
    var id = UUID().uuidString
    var message: String
    var userName: String
    var tintColor: Color
}

var allMessages : [Message] = [

    Message(message: "Can we go to the park.", userName: "iJustine", tintColor: .pink),
    Message(message: "We can go down to the store with the dog. It is not too far away.", userName: "Jenna", tintColor: .red),
    Message(message: "Can we go to the park.", userName: "Aaron", tintColor: .green),
    Message(message: "We can go down to the store with the dog. It is not too far away.", userName: "Kaviya", tintColor: .yellow),
    Message(message: "Can we go to the park.", userName: "Finch", tintColor: .orange),
    Message(message: "Can we go to the park.", userName: "Jeff", tintColor: .pink),
    Message(message: "Can we go to the park.", userName: "Melinda", tintColor: .red),
    Message(message: "Can we go to the park.", userName: "Cook", tintColor: .green),
    Message(message: "Can we go to the park.", userName: "Jimmy", tintColor: .yellow),
    Message(message: "Can we go to the park.", userName: "Tom", tintColor: .orange),
    Message(message: "Can we go to the park.", userName: "Ellen", tintColor: .pink),
    Message(message: "Can we go to the park.", userName: "Julia", tintColor: .red),
    Message(message: "Can we go to the park.", userName: "Ashley", tintColor: .green),
    Message(message: "Can we go to the park.", userName: "Emily", tintColor: .yellow),
]


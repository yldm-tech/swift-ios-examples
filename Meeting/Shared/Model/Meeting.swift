//
//  Meeting.swift
//  Meeting App UI (iOS)
//
//  Created by Balaji on 02/07/21.
//

import SwiftUI

// Model...

struct Meeting: Identifiable {
    
    var id = UUID().uuidString
    var title: String
    var timing: Date
    var cardColor: Color = Color("Blue")
    var turnedOn: Bool = true
    // Type...
    var memeberType : String = "Public"
    // Memebers...
    // Im simply creating a empty array for member count.....
    var members: [String] = Array(repeating: "", count: 10)
}

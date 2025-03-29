//
//  Event.swift
//  Event
//
//  Created by Balaji on 23/07/21.
//

import SwiftUI

// Sample Model and Data....

// Colors for card...
let colors: [Color] = [.red,.orange,.blue,.green,.pink]

struct Event: Identifiable{
    var id = UUID().uuidString
    var date: String
    var title: String
    var timing: String
    var color = colors.randomElement() ?? .red
}

var events: [Event] = [

    Event(date: "Jul 18", title: "GYM", timing: "1:20 - 3:30"),
    Event(date: "Jul 19", title: "Study", timing: "12:20 - 4:30"),
    Event(date: "Jul 20", title: "Hospital", timing: "11:20 - 2:30"),
    Event(date: "Jul 21", title: "Work", timing: "10:20 - 12:30"),
    Event(date: "Jul 22", title: "Gaming", timing: "01:20 - 3:30"),
    Event(date: "Jul 23", title: "Chess", timing: "12:20 - 1:30"),
]


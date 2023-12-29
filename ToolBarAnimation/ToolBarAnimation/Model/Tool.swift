//
//  Tool.swift
//  ToolBarAnimation
//
//  Created by Balaji on 01/08/22.
//

import SwiftUI

// MARK: Tool Model And Sample Tools
struct Tool: Identifiable{
    var id: String = UUID().uuidString
    var icon: String
    var name: String
    var color: Color
    var toolPostion: CGRect = .zero
}

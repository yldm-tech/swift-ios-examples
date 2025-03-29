//
//  TextBox.swift
//  ImageDrawing (iOS)
//
//  Created by Balaji on 20/04/21.
//

import SwiftUI
import PencilKit

struct TextBox: Identifiable {

    var id = UUID().uuidString
    var text: String = ""
    var isBold: Bool = false
    // For Dragging the view over the screen
    var offset: CGSize = .zero
    var lastOffset: CGSize = .zero
    var textColor: Color = .white
    // you can add what ever property here....
    // im simply stopping on this...
    var isAdded: Bool = false
}

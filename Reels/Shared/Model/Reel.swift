//
//  Reel.swift
//  Reels (iOS)
//
//  Created by Balaji on 29/06/21.
//

import SwiftUI
import AVKit

struct Reel: Identifiable {

    var id = UUID().uuidString
    var player: AVPlayer?
    var mediaFile: MediaFile
}

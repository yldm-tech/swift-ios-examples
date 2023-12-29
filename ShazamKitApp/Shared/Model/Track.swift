//
//  Track.swift
//  ShazamKitApp (iOS)
//
//  Created by Balaji on 14/06/21.
//

import SwiftUI

struct Track: Identifiable {
    var id = UUID().uuidString
    // Track Info...
    var title: String
    var artist: String
    var artwork: URL
    var genres: [String]
    var appleMusicURL: URL
}

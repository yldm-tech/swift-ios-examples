//
//  Video.swift
//  Snap (iOS)
//
//  Created by Balaji on 15/01/21.
//

import SwiftUI
import AVKit

// Video Model And Model Videos...

struct Video: Identifiable {
    var id = UUID().uuidString
    var player: AVPlayer
}

// Getting URL From Bundle...
func getBundleURL(fileName: String)->URL{
    let bundle = Bundle.main.path(forResource: fileName, ofType: "mp4")
    
    return URL(fileURLWithPath: bundle!)
}

var videos = [

    Video(player: AVPlayer(url: getBundleURL(fileName: "video1"))),
    Video(player: AVPlayer(url: getBundleURL(fileName: "video2"))),
    Video(player: AVPlayer(url: getBundleURL(fileName: "video3"))),
    Video(player: AVPlayer(url: getBundleURL(fileName: "video4"))),
    Video(player: AVPlayer(url: getBundleURL(fileName: "video5"))),
    Video(player: AVPlayer(url: getBundleURL(fileName: "video6"))),
    Video(player: AVPlayer(url: getBundleURL(fileName: "video7"))),
    Video(player: AVPlayer(url: getBundleURL(fileName: "video8"))),
]

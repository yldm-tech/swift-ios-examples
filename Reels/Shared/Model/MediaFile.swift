//
//  MediaFile.swift
//  Reels (iOS)
//
//  Created by Balaji on 29/06/21.
//

import SwiftUI

// Sample Model And Reels Videos...
struct MediaFile: Identifiable{
    var id = UUID().uuidString
    var url: String
    var title: String
    var isExpanded: Bool = false
}

var MediaFileJSON = [
    
   MediaFile(url: "Reel1", title: "Apple AirTag....."),
   MediaFile(url: "Reel2", title: "omg..... Animal crossing"),
   MediaFile(url: "Reel3", title: "So hyped for Halo...."),
   MediaFile(url: "Reel4", title: "SponsorShip....."),
   MediaFile(url: "Reel5", title: "I've been creating more vertical 30 second content"),
   MediaFile(url: "Reel6", title: "The brand new Apple Tower Theater opens"),
   
]

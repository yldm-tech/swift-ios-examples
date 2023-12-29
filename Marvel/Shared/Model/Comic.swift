//
//  Comic.swift
//  Marvel API
//
//  Created by Balaji on 14/03/21.
//

import SwiftUI

struct APIComicResult: Codable {
    var data: APIComicData
}

struct APIComicData: Codable {
    var count: Int
    var results: [Comic]
}

struct Comic: Identifiable,Codable {
    var id: Int
    var title: String
    var description: String?
    var thumbnail: [String:String]
    var urls: [[String: String]]
}

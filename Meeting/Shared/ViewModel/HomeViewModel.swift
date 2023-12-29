//
//  HomeViewModel.swift
//  Meeting App UI (iOS)
//
//  Created by Balaji on 02/07/21.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var addNewMeeting = false
    
    @Published var meetings: [Meeting] = [

    ]
}

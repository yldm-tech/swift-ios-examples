//
//  AnimationViewModel.swift
//  MatchedTransition (iOS)
//
//  Created by Balaji on 20/05/21.
//

import SwiftUI

class AnimationViewModel: ObservableObject {

    // Properties And Actions To be done when button is clicked...
    @Published var airplaneMode = false
    @Published var dataMode = false
    @Published var NFCMode = false
    @Published var hotspotMode = false
    @Published var airDropMode = false
    @Published var WIFIMode = false
    
    @Published var enalrgeActions = false
    @Published var showDetail = false
}

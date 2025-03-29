//
//  HeaderViewModel.swift
//  Animated_Header (iOS)
//
//  Created by Balaji on 12/02/21.
//

import SwiftUI

class HeaderViewModel: ObservableObject {

    // To Capture Start MinY value For Calculations....
    @Published var startMinY : CGFloat = 0
    
    @Published var offset: CGFloat = 0
    
    // Header View Properties...
    
    @Published var headerOffset: CGFloat = 0
    
    // It will be used for getting top and bottom offsets for header view...
    @Published var topScrollOffset: CGFloat = 0
    @Published var bottomScrollOffset: CGFloat = 0
}


//
//  ProfileDetailModel.swift
//  WhatsApp Hero Animation (iOS)
//
//  Created by Balaji on 27/03/21.
//

import SwiftUI

class ProfileDetailModel: ObservableObject {

    @Published var showProfile = false
    
    // Storing The Selected profile...
    @Published var selectedProfile : Profile!
    
    // To Show Big Image...
    @Published var showEnlargedImage = false
    
    // Drag to close...
    @Published var offset: CGFloat = 0
}

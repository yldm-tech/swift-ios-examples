//
//  ScrollRefreshable.swift
//  ScrollRefreshable
//
//  Created by Balaji on 08/09/21.
//

import SwiftUI

// See My ScrollRefreshable Video to add .refreshable modifier to scrollview...
// link in description....
struct ScrollRefreshable<Content: View>: View {
    
    var content: Content
    var onRefresh: () async ->()
    
    init(title: String,tintColor: Color,@ViewBuilder content: @escaping ()->Content,onRefresh: @escaping () async ->()){
        
        self.content = content()
        self.onRefresh = onRefresh
        
        // Moving Refresh Control indicator....
        let refreshControl = UIRefreshControl.appearance()
        
        refreshControl.bounds = CGRect(x: refreshControl.bounds.origin.x,
                                       y: -(350 - getSafeArea().top) + refreshControl.bounds.origin.y,
                                       width: refreshControl.bounds.size.width,
                                       height: refreshControl.bounds.size.height)
        
        // Modifying Refresh Control...
        UIRefreshControl.appearance().attributedTitle = NSAttributedString(string: title)
        UIRefreshControl.appearance().tintColor = UIColor(tintColor)
    }
    
    var body: some View {
        
        List{
            
            // Preview Bug....
            content
                .listRowSeparatorTint(.clear)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
        .refreshable {
            await onRefresh()
        }
    }
}

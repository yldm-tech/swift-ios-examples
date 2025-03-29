//
//  CustomContextMenu.swift
//  CustomContentMenu (iOS)
//
//  Created by Balaji on 01/07/21.
//

import SwiftUI

// Custom View Builder....
struct CustomContextMenu<Content: View,Preview: View>: View {
    
    var content: Content
    var preview: Preview
    // List of Actions...
    var menu: UIMenu
    var onEnd: ()->()
    
    init(@ViewBuilder content: @escaping ()->Content,@ViewBuilder preview: @escaping ()->Preview,actions: @escaping ()->UIMenu,onEnd: @escaping ()->()){
        
        
        self.content = content()
        self.preview = preview()
        self.menu = actions()
        self.onEnd = onEnd
    }
    
    var body: some View {
        
        ZStack{
            
            content
            // Hiding Main View...
                .hidden()
                .overlay(
                
                    // it will take whole view....
                    // simple techinique use it in overlay....
                    ContextMenuHelper(content: content, preview: preview,actions: menu,onEnd: onEnd)
                )
        }
    }
}

struct CustomContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// Custom View for Context Menu....
struct ContextMenuHelper<Content: View,Preview: View>: UIViewRepresentable{
    
    var content: Content
    var preview: Preview
    var actions: UIMenu
    var onEnd: ()->()
    
    init(content: Content,preview: Preview,actions: UIMenu,onEnd: @escaping ()->()){
        self.content = content
        self.preview = preview
        self.actions = actions
        self.onEnd = onEnd
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView()
        view.backgroundColor = .clear
        
        // setting our content view as Main Interaction view....
        let hostView = UIHostingController(rootView: content)
        
        // setting constraints...
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Constarints....
        let constraints = [
        
            hostView.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            hostView.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            hostView.view.heightAnchor.constraint(equalTo: view.heightAnchor),
        ]
        
        view.addSubview(hostView.view)
        view.addConstraints(constraints)
        
        // setting interaction...
        let interaction = UIContextMenuInteraction(delegate: context.coordinator)
        
        view.addInteraction(interaction)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    // COntext Menu Delegate...
    class Coordinator: NSObject,UIContextMenuInteractionDelegate{
        
        var parent: ContextMenuHelper
        init(parent: ContextMenuHelper) {
            self.parent = parent
        }
        
        // Delegate Methods....
        
        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
            
            return UIContextMenuConfiguration(identifier: nil) {
                
                // your view.....
                let previewController = UIHostingController(rootView: self.parent.preview)
                
                previewController.view.backgroundColor = .clear
                
                return previewController
                
            } actionProvider: { items in
                
                // your actions....
                return self.parent.actions
            }

        }
        
        // if you need context menu to be expanded...
        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
            
            animator.addCompletion {
                self.parent.onEnd()
            }
        }
    }
}

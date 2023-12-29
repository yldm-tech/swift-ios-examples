//
//  DrawingViewModel.swift
//  ImageDrawing (iOS)
//
//  Created by Balaji on 20/04/21.
//

import SwiftUI
import PencilKit

// It holds all our drawing data...

class DrawingViewModel: ObservableObject {

    @Published var showImagePicker = false
    @Published var imageData: Data = Data(count: 0)
    
    // Canvas for drawing...
    @Published var canvas = PKCanvasView()
    // Tool picker..
    @Published var toolPicker = PKToolPicker()
    
    // List Of TextBoxes...
    @Published var textBoxes : [TextBox] = []
    
    @Published var addNewBox = false
    
    // Current Index...
    @Published var currentIndex : Int = 0
    
    // Saving The View Frame Size...
    @Published var rect: CGRect = .zero
    
    // Alert...
    @Published var showAlert = false
    @Published var message = ""
    
    // cancel function...
    func cancelImageEditing(){
        imageData = Data(count: 0)
        canvas = PKCanvasView()
        textBoxes.removeAll()
    }
    
    // cancel the text view..
    func cancelTextView(){
        
        // showing again the tool bar...
        toolPicker.setVisible(true, forFirstResponder: canvas)
        canvas.becomeFirstResponder()
        
        withAnimation{
            addNewBox = false
        }
        
        // removing if cancelled..
        // avoiding the removal of already added....
        if textBoxes[currentIndex].isAdded{
         
            textBoxes.removeLast()
        }
    }
    
    func saveImage(){
        
        // generating Image from both canvas and our textboxes View...
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        // canvas...
        canvas.drawHierarchy(in: CGRect(origin: .zero, size: rect.size), afterScreenUpdates: true)
        
        // drawing text boxes...
        
        let SwiftUIView = ZStack{
            
            ForEach(textBoxes){[self] box in
                
                Text(textBoxes[currentIndex].id == box.id && addNewBox ? "" : box.text)
                    // you can also include text size in model..
                    // and can use those text sizes in these text boxes...
                    .font(.system(size: 30))
                    .fontWeight(box.isBold ? .bold : .none)
                    .foregroundColor(box.textColor)
                    .offset(box.offset)
                
            }
        }
        
        let controller = UIHostingController(rootView: SwiftUIView).view!
        controller.frame = rect
        
        // clearing bg...
        controller.backgroundColor = .clear
        canvas.backgroundColor = .clear
        
        controller.drawHierarchy(in: CGRect(origin: .zero, size: rect.size), afterScreenUpdates: true)
        
        // getting image....
        let generatedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // ending render...
        UIGraphicsEndImageContext()
        
        if let image = generatedImage?.pngData(){
            
            // saving image as PNG...
            UIImageWriteToSavedPhotosAlbum(UIImage(data: image)!, nil, nil, nil)
            print("success....")
            self.message = "Saved Successfully !!!"
            self.showAlert.toggle()
        }
    }
}

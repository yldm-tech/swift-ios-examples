//
//  DrawingScreen.swift
//  ImageDrawing (iOS)
//
//  Created by Balaji on 20/04/21.
//

import SwiftUI
import PencilKit

struct DrawingScreen: View {
    @EnvironmentObject var model: DrawingViewModel
    var body: some View {
        
        ZStack{
            
            GeometryReader{proxy -> AnyView in
                
                let size = proxy.frame(in: .global)
                
                DispatchQueue.main.async {
                    if model.rect == .zero{
                        model.rect = size
                    }
                }
                
                return AnyView(
                
                    ZStack{
                        
                        // UIkit Pencil Kit Drawing View...
                        CanvasView(canvas: $model.canvas, imageData: $model.imageData, toolPicker: $model.toolPicker,rect: size.size)
                        
                        // CUstom Texts....
                        
                        // displaying text boxes..
                        ForEach(model.textBoxes){box in
                            
                            Text(model.textBoxes[model.currentIndex].id == box.id && model.addNewBox ? "" : box.text)
                                // you can also include text size in model..
                                // and can use those text sizes in these text boxes...
                                .font(.system(size: 30))
                                .fontWeight(box.isBold ? .bold : .none)
                                .foregroundColor(box.textColor)
                                .offset(box.offset)
                            // drag gesutre...
                                .gesture(DragGesture().onChanged({ (value) in
                                    
                                    let current = value.translation
                                    // Adding with last Offset...
                                    let lastOffset = box.lastOffset
                                    let newTranslation = CGSize(width: lastOffset.width + current.width, height: lastOffset.height + current.height)
                                    
                                    model.textBoxes[getIndex(textBox: box)].offset = newTranslation
                                    
                                }).onEnded({ (value) in
                                    
                                    // saving the last offset for exact drag postion...
                                    model.textBoxes[getIndex(textBox: box)].lastOffset = model.textBoxes[getIndex(textBox: box)].offset
                                    
                                }))
                            // editing the typed one...
                                .onLongPressGesture {
                                    // closing the toolbar...
                                    model.toolPicker.setVisible(false, forFirstResponder: model.canvas)
                                    model.canvas.resignFirstResponder()
                                    model.currentIndex = getIndex(textBox: box)
                                    withAnimation{
                                        model.addNewBox = true
                                    }
                                }
                        }
                    }
                )
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button(action: model.saveImage, label: {
                    Text("Save")
                })
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button(action: {
                    
                    // creating One New Box...
                    model.textBoxes.append(TextBox())
                    
                    // upating index..
                    model.currentIndex = model.textBoxes.count - 1
                    
                    withAnimation{
                        model.addNewBox.toggle()
                    }
                    // closing the tool bar...
                    model.toolPicker.setVisible(false, forFirstResponder: model.canvas)
                    model.canvas.resignFirstResponder()
                }, label: {
                    Image(systemName: "plus")
                })
            }
        })
    }
    
    func getIndex(textBox: TextBox)->Int{
        
        let index = model.textBoxes.firstIndex { (box) -> Bool in
            return textBox.id == box.id
        } ?? 0
        
        return index
    }
}

struct DrawingScreen_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct CanvasView: UIViewRepresentable {
    
    // since we need to get the drawings so were binding...
    @Binding var canvas: PKCanvasView
    @Binding var imageData : Data
    @Binding var toolPicker: PKToolPicker
    
    // View Size..
    var rect: CGSize
    
    func makeUIView(context: Context) -> PKCanvasView {
        
        canvas.isOpaque = false
        canvas.backgroundColor = .clear
        canvas.drawingPolicy = .anyInput

        // appending the image in canvas subview...
        if let image = UIImage(data: imageData){
            
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            
            // basically were setting image to the back of the canvas...
            let subView = canvas.subviews[0]
            subView.addSubview(imageView)
            subView.sendSubviewToBack(imageView)
            
            // showing tool picker...
            // were setting it as first responder and making it as visible...
            toolPicker.setVisible(true, forFirstResponder: canvas)
            toolPicker.addObserver(canvas)
            canvas.becomeFirstResponder()
        }
        
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
        // Update UI will update for each actions...
    }
}

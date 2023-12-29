//
//  Home.swift
//  ImageDrawing (iOS)
//
//  Created by Balaji on 20/04/21.
//

import SwiftUI

struct Home: View {
    
    @StateObject var model = DrawingViewModel()
    
    var body: some View {
        
        // Home Screen...
        ZStack{
            
            NavigationView{
                
                VStack{
                    
                    if let _ = UIImage(data: model.imageData){
                        

                        DrawingScreen()
                            .environmentObject(model)
                        // setting cancel button if image selected...
                            .toolbar(content: {
                                
                                ToolbarItem(placement: .navigationBarLeading) {
                                    
                                    Button(action: model.cancelImageEditing, label: {
                                        Image(systemName: "xmark")
                                    })
                                }
                            })
                    }
                    else{
                        // Show Image picker Button..
                        Button(action: {model.showImagePicker.toggle()}, label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundColor(.black)
                                .frame(width: 70, height: 70)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                                .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: -5)
                        })
                    }
                }
                .navigationTitle("Image Editor")
            }
            
            if model.addNewBox{
                
                Color.black.opacity(0.75)
                    .ignoresSafeArea()
                
                // TextField...
                TextField("Type Here", text: $model.textBoxes[model.currentIndex].text)
                    .font(.system(size: 35, weight: model.textBoxes[model.currentIndex].isBold ? .bold : .regular))
                    .colorScheme(.dark)
                    .foregroundColor(model.textBoxes[model.currentIndex].textColor)
                    .padding()
                
                // add and cancel button...
                HStack{
                    
                    Button(action: {
                        // toggling the isAdded...
                        model.textBoxes[model.currentIndex].isAdded = true
                        // closing the view...
                        model.toolPicker.setVisible(true, forFirstResponder: model.canvas)
                        model.canvas.becomeFirstResponder()
                        withAnimation{
                            model.addNewBox = false
                        }
                    }, label: {
                        Text("Add")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                    })
                    
                    Spacer()
                    
                    Button(action: model.cancelTextView, label: {
                        Text("Cancel")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                    })
                }
                .overlay(
                    HStack(spacing: 15){
                        
                        // Color Picker...
                        ColorPicker("", selection: $model.textBoxes[model.currentIndex].textColor)
                            .labelsHidden()
                        
                        Button(action: {
                            model.textBoxes[model.currentIndex].isBold.toggle()
                        }, label: {
                            Text(model.textBoxes[model.currentIndex].isBold ? "Normal" : "Bold")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        })
                    }
                )
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        // Showing Image Picker to pick Image...
        .sheet(isPresented: $model.showImagePicker, content: {
            ImagePicker(showPicker: $model.showImagePicker, imageData: $model.imageData)
        })
        .alert(isPresented: $model.showAlert, content: {
            Alert(title: Text("Message"), message: Text(model.message), dismissButton: .destructive(Text("Ok")))
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

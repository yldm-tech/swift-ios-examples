//
//  IconViewModel.swift
//  IconGenerator (iOS)
//
//  Created by Balaji on 28/01/22.
//

import SwiftUI

class IconViewModel: ObservableObject {
    
    // MARK: Selected Image For Icon
    @Published var pickedImage: NSImage?
    
    // MARK: Loading And Alert
    @Published var isGenerating: Bool = false
    @Published var alertMsg: String = ""
    @Published var showAlert: Bool = false
    
    // MARK: Icon Set Image Sizes
    @Published var iconSizes: [Int] = [
    
        20,60,58,87,80,120,180,40,29,76,152
        ,167,1024,16,32,64,128,256,512,1024
    ]
    
    // MARK: Picking Image using NSOpen Panel
    func PickImage(){
        
        let panel = NSOpenPanel()
        panel.title = "Choose a Picture"
        panel.showsResizeIndicator = true
        panel.showsHiddenFiles = false
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.allowedContentTypes = [.image,.png,.jpeg]
        
        if panel.runModal() == .OK{
            
            if let result = panel.url?.path{
                
                let image = NSImage(contentsOf: URL(fileURLWithPath: result))
                self.pickedImage = image
            }
            else{
                // MARK: Error
            }
        }
    }
    
    func generateIconSet(){
        
        // MARK: Steps
        // 1. Asking User where to store icons
        folderSelector { folderURL in
            
            // 2. Creataing AppIcon.appiconset folder in it
            let modifiedURL = folderURL.appendingPathComponent("AppIcon.appiconset")
            
            self.isGenerating = true
            
            // Doing in Thread
            DispatchQueue.global(qos: .userInteractive).async {
                
                do{
                    
                    let manager = FileManager.default
                    try manager.createDirectory(at: modifiedURL, withIntermediateDirectories: true, attributes: [:])
                    
                    // 3. Writing Contents.json file inside the folder
                    self.writeContentsFile(folderURL: modifiedURL.appendingPathComponent("Contents.json"))
                    // 4. Generating Icon set and writing inside the folder
                    
                    if let pickedImage = self.pickedImage {
                        
                        self.iconSizes.forEach { size in
                            
                            let imageSize = CGSize(width: CGFloat(size), height: CGFloat(size))
                            // So each image will be like 20.png, 32.png...
                            let imageURL = modifiedURL.appendingPathComponent("\(size).png")
                            
                            pickedImage.resizeImage(size: imageSize)
                                .writeImage(to: imageURL)
                        }
                        
                        DispatchQueue.main.async {
                            self.isGenerating = false
                            // Saved Alert
                            self.alertMsg = "Generated Successfully!"
                            self.showAlert.toggle()
                        }
                    }
                }
                catch{
                    // MARK: Error
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self.isGenerating = false
                    }
                }
            }
        }
    }
    
    // MARK: Writing Contents.json
    func writeContentsFile(folderURL: URL){
        
        do{
            
            let bundle = Bundle.main.path(forResource: "Contents", ofType: "json") ?? ""
            let url = URL(fileURLWithPath: bundle)
            
            try Data(contentsOf: url).write(to: folderURL, options: .atomic)
        }
        catch{
            // MARK: Error
        }
    }
    
    // MARK: Folder Selector Using NSOpenPanel
    func folderSelector(completion: @escaping (URL)->()){
        
        let panel = NSOpenPanel()
        panel.title = "Choose a Folder"
        panel.showsResizeIndicator = true
        panel.showsHiddenFiles = false
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.canCreateDirectories = true
        panel.allowedContentTypes = [.folder]
        
        if panel.runModal() == .OK{
            
            if let result = panel.url?.path{
                completion(URL(fileURLWithPath: result))
            }
            else{
                // MARK: Error
            }
        }
    }
}

// MARK: Extending NSImage to resize the Image with new Size
extension NSImage{
    func resizeImage(size: CGSize)->NSImage{
        
        // Reducing Scaling Factor
        let scale = NSScreen.main?.backingScaleFactor ?? 1
        
        let newSize = CGSize(width: size.width / scale, height: size.height / scale)
        
        let newImage = NSImage(size: newSize)
        newImage.lockFocus()
        
        // Drawing Image
        self.draw(in: NSRect(origin: .zero, size: newSize))
        
        newImage.unlockFocus()
        
        return newImage
    }
    
    // MARK: Writing Resized image as PNG
    func writeImage(to: URL){
        
        // Converting as PNG
        guard let data = tiffRepresentation,let representation = NSBitmapImageRep(data: data),let pngData = representation.representation(using: .png, properties: [:]) else{
            return
        }
        
        try? pngData.write(to: to, options: .atomic)
    }
}

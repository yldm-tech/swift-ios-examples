//
//  DownloadTaskModel.swift
//  DownloadTask (iOS)
//
//  Created by Balaji on 06/04/21.
//

import SwiftUI

class DownloadTaskModel: NSObject,ObservableObject,URLSessionDownloadDelegate,UIDocumentInteractionControllerDelegate {

    @Published var downloadURL: URL!
    
    // Alert...
    @Published var alertMsg = ""
    @Published var showAlert = false
    
    // Saving Download task refernce for cancelling...
    @Published var downloadtaskSession : URLSessionDownloadTask!
    
    // Progress...
    @Published var downloadProgress: CGFloat = 0
    
    // Show Progress View...
    @Published var showDownlodProgress = false
    
    // Download Function...
    func startDownload(urlString: String){
        
        // checking for valid URL
        guard let ValidURL = URL(string: urlString) else{
            self.reportError(error: "Invalid URL !!!")
            return
        }
        
        // preventing downloading the same file again...
        
        let directoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        if FileManager.default.fileExists(atPath: directoryPath.appendingPathComponent(ValidURL.lastPathComponent).path){
            
            print("yes file found")
            
            let controller = UIDocumentInteractionController(url: directoryPath.appendingPathComponent(ValidURL.lastPathComponent))
            
            // it needs a delegate...
            controller.delegate = self
            controller.presentPreview(animated: true)
        }
        else{
            print("no file found")
            // valid URL...
            
            downloadProgress = 0
            withAnimation{showDownlodProgress = true}
            
            // Download task...
            // since were going to get the progress as well as location of file so were usig delegate...
            let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
            
            downloadtaskSession = session.downloadTask(with: ValidURL)
            downloadtaskSession.resume()
        }
    }
    
    // Report Error function...
    func reportError(error: String){
        alertMsg = error
        showAlert.toggle()
    }
    
    // Implementing URLSeesion Functions...
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        // since it will download it as temporay data...
        // so were going to save it in app document directory and showing it in document controller...
        
        guard let url = downloadTask.originalRequest?.url else {
            DispatchQueue.main.async {
                
                self.reportError(error: "Something went wrong please try again later")
            }
            return
        }
        
        // directory Path...
        let directoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        // creating one for storing File....
        //destination URL
        // getting like ijustine.mp4....
        let destinationURL = directoryPath.appendingPathComponent(url.lastPathComponent)
        
        // if already file is there removing that...
        try? FileManager.default.removeItem(at: destinationURL)
        
        do{
            
            // copying temp file to directory...
            try FileManager.default.copyItem(at: location, to: destinationURL)
            
            // if success....
            print("success")
            // closing progress view...
            DispatchQueue.main.async {
                
                withAnimation{self.showDownlodProgress = false}
                
                // presenting the file with the help of document interaction controller from UIKit
                
                let controller = UIDocumentInteractionController(url: destinationURL)
                
                // it needs a delegate...
                controller.delegate = self
                controller.presentPreview(animated: true)
            }
        }
        catch{
            DispatchQueue.main.async {
                self.reportError(error: "Please try again later !!!")
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
     
        // getting progress....
        let progress = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        
        // since url session will be running in BG Thread..
        // so UI updates will be done on main threads...
        DispatchQueue.main.async {
            self.downloadProgress = progress
        }
    }
    
    // error
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        DispatchQueue.main.async {
            
            if let error = error{
                withAnimation{self.showDownlodProgress = false}
                self.reportError(error: error.localizedDescription)
                return
            }
        }
    }
    
    // cancel Task...
    func cancelTask(){
        if let task = downloadtaskSession,task.state == .running{
            // cancelling...
            downloadtaskSession.cancel()
            // closing view...
            withAnimation{self.showDownlodProgress = false}
        }
    }
    
    // Sub Functions for presenting view...
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        
        return UIApplication.shared.windows.first!.rootViewController!
    }
}

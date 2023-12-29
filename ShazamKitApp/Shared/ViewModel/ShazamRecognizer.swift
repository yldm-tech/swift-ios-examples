//
//  ShazamRecognizer.swift
//  ShazamKitApp (iOS)
//
//  Created by Balaji on 14/06/21.
//

import SwiftUI
// Shazam Kit...
import ShazamKit
import AVKit

class ShazamRecognizer: NSObject,ObservableObject,SHSessionDelegate {
    
    @Published var session = SHSession()
    
    // Audio Engine....
    @Published var audioEngine = AVAudioEngine()
    
    // Error....
    @Published var errorMsg = ""
    @Published var showError = false
    
    // Recording Status...
    @Published var isRecording = false
    
    // FOund Track...
    @Published var matchedTrack: Track!
    
    override init() {
        super.init()
        // Setting Delegate...
        session.delegate = self
    }
    
    func session(_ session: SHSession, didFind match: SHMatch) {
        
        // Match Found....
        if let firstItem = match.mediaItems.first{
            
            DispatchQueue.main.async {
                
                self.matchedTrack = Track(title: firstItem.title ?? "",
                                          artist: firstItem.artist ?? "",
                                          artwork: firstItem.artworkURL ?? URL(string: "")!
                                          , genres: firstItem.genres,
                                          appleMusicURL: firstItem.appleMusicURL ?? URL(string: "")!)
                
                self.stopRecording()
            }
        }
    }
    
    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        
        // No match...
        DispatchQueue.main.async {
            
            self.errorMsg = error?.localizedDescription ?? "No Music Found....."
            self.showError.toggle()
            // stopping Audio recording....
            self.stopRecording()
        }
    }
    
    func stopRecording(){
        audioEngine.stop()
        withAnimation{
            isRecording = false
        }
    }
    
    // Fetch Music....
    func listnenMusic(){
        
        let audioSession = AVAudioSession.sharedInstance()
        
        // checking fro permission....
        audioSession.requestRecordPermission { status in
            
            if status{
                self.recordAudio()
            }
            else{
                self.errorMsg = "Please Allow Microphone Access !!!"
                self.showError.toggle()
            }
        }
    }
    
    func recordAudio(){
        
        // checking if already recording...
        // then stopping it....
        if audioEngine.isRunning{
            self.stopRecording()
            return
        }
        
        // recording audio....
        // Firts create a node...
        // Then Listnen to it....
        let inputNode = audioEngine.inputNode
        // Format.....
        let format = inputNode.outputFormat(forBus: .zero)
        
        // removing tap if already installed....
        inputNode.removeTap(onBus: .zero)
        
        // Installing tap....
        inputNode.installTap(onBus: .zero, bufferSize: 1024, format: format) { buffer, time in
            
            // It will Listnen to music continously....
            // Starting Shazam Session...
            self.session.matchStreamingBuffer(buffer, at: time)
        }
        
        // starting Audio Service...
        audioEngine.prepare()
        
        do{
            try audioEngine.start()
            print("Started")
            withAnimation{
                self.isRecording = true
            }
        }
        catch{
            self.errorMsg = error.localizedDescription
            self.showError.toggle()
        }
    }
}

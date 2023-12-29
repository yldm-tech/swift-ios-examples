//
//  Home.swift
//  ShazamKitApp (iOS)
//
//  Created by Balaji on 14/06/21.
//

import SwiftUI

struct Home: View {
    
    // Creating Object...
    @StateObject var shazamSession = ShazamRecognizer()
    
    var body: some View {
        
        ZStack{
            
            NavigationView{
                
                VStack{
                    
                    // Record Button...
                    Button {
                        shazamSession.listnenMusic()
                    } label: {
                        
                        Image(systemName: shazamSession.isRecording ? "stop" : "mic")
                            .font(.system(size: 35).bold())
                        // fill variant...
                            .symbolVariant(.fill)
                            .padding(30)
                            .background(Color.cyan,in: Circle())
                            .foregroundStyle(.white)
                    }

                }
                .navigationTitle("Shazam Kit")
            }
            
            if let track = shazamSession.matchedTrack{
                
                ZStack{
                    
                    // Background Blurred Image....
                    AsyncImage(url: track.artwork){phase in
                        
                        if let image = phase.image{
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                        else{
                            Color.white
                        }
                    }
                    .overlay(.ultraThinMaterial)
                    // max width...
                    .frame(width: getRect().width)
                    
                    // Track Info....
                    VStack(spacing: 15){
                        
                        AsyncImage(url: track.artwork){phase in
                            
                            if let image = phase.image{
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: getRect().width - 100,height: 300)
                                    .cornerRadius(12)
                            }
                            else{
                                ProgressView()
                            }
                        }
                        .frame(width: getRect().width - 100,height: 300)
                        
                        Text(track.title)
                            .font(.title2.bold())
                            .padding(.horizontal)
                        
                        Text("Artist: **\(track.artist)**")
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            
                            Text("Genres")
                                .padding(.leading)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                
                                HStack(spacing: 10){
                                    
                                    ForEach(track.genres,id: \.self){genre in
                                        
                                        Button {
                                            
                                        } label: {
                                            Text(genre)
                                                .font(.caption)
                                        }
                                        .buttonStyle(.bordered)
                                        .controlSize(.small)
//                                        .controlProminence(.increased)
//                                        .tint(.black)

                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        // Apple Music Link...
                        Link(destination: track.appleMusicURL) {
                            
                            Text("Play in Apple Music")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
//                        .controlProminence(.increased)
//                        .tint(.blue)
//                        .padding(.horizontal)
                    }
                    // CLose Button...
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(
                    
                        Button(action: {
                        // Resetting View....
                        shazamSession.matchedTrack = nil
                        shazamSession.stopRecording()
                    }, label: {
                        
                        Image(systemName: "xmark")
                            .font(.caption)
                            .padding(10)
                            .background(Color.white,in: Circle())
                            .foregroundStyle(.black)
                    })
                            .padding(10)
                        
                        ,alignment: .topTrailing
                    
                    )
                }
            }
        }
        .alert(shazamSession.errorMsg, isPresented: $shazamSession.showError) {
            Button("Close",role: .cancel){
                
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// extedning View to get Screen Size...
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}

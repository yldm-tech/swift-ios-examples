//
//  StreamViewModel.swift
//  Stream Tutorials
//
//  Created by Balaji on 23/03/21.
//

import SwiftUI
import StreamChat

class StreamViewModel: ObservableObject {

    @Published var userName = ""
    
    @AppStorage("userName") var storedUser = ""
    @AppStorage("log_Status") var logStatus = false
    
    // Alert....
    @Published var error = false
    @Published var errorMsg = ""
    
    // Loading Screen...
    @Published var isLoading = false
    
    // Channel Data...
    @Published var channels : [ChatChannelController.ObservableObject]!
    
    // Create New Channel...
    @Published var createNewChannel = false
    @Published var channelName = ""
    
    func logInUser(){
        
        // Logging In User....
        
        withAnimation{isLoading = true}
        
        // Upadting User Profile...
        // you can give user image url if want....
        ChatClient.shared.currentUserController().updateUserData(name: userName, imageURL: nil, userExtraData: .defaultValue) { err in
            
            withAnimation{self.isLoading = false}
            
            if let error = err{
                self.errorMsg = error.localizedDescription
                self.error.toggle()
                return
            }
            
            // Else SUccessful...
            // storing user Name...
            self.storedUser = self.userName
            self.logStatus = true
            
            ChatClient.shared.currentUserController().reloadUserIfNeeded()
            
        }
    }
    
    // Fetching All Channels...
    func fetchAllChannels(){
        
        if channels == nil{
            // filter...
            
            ChatClient.shared.currentUserController().reloadUserIfNeeded()
            
            let filter = Filter<ChannelListFilterScope>.equal("type", to: "messaging")
            
            let request =  ChatClient.shared.channelListController(query: .init(filter: filter))
            
            request.synchronize { (err) in
                if let error = err{
                    self.errorMsg = error.localizedDescription
                    self.error.toggle()
                    return
                }

                DispatchQueue.main.async {
                    
                    // else Successful...
                    self.channels = request.channels.compactMap({ (channel) -> ChatChannelController.ObservableObject? in
                        
                        return ChatClient.shared.channelController(for: channel.cid).observableObject
                    })
                }
            }
        }
    }
    
    // Creating New CHannel...
    func createChannel(){
        
        withAnimation{self.isLoading = true}
        
        let normalizedChannelName = channelName.replacingOccurrences(of: " ", with: "-")
        
        let newChannel = ChannelId(type: .messaging, id: normalizedChannelName)
        
        // you can givve image url to channel...
        // same you can also give image url to user....
        let request = try! ChatClient.shared.channelController(createChannelWithId: newChannel, name: normalizedChannelName, imageURL: nil, extraData: .defaultValue)
        
        request.synchronize { (err) in
            
            withAnimation{self.isLoading = false}
            
            if let error = err{
                self.errorMsg = "Try Again Later !!!\n\nAvoid Using Special Character like $,'%..etc\n\n\(error.localizedDescription)"
                self.error.toggle()
                return
            }
            
            // Succes....
            // closing Loading And New Channle View....
            self.channelName = ""
            withAnimation{self.createNewChannel = false}
            self.channels = nil
            self.fetchAllChannels()
        }
    }
}

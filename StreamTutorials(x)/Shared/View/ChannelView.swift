//
//  ChannelView.swift
//  Stream Tutorials
//
//  Created by Balaji on 23/03/21.
//

import SwiftUI
import StreamChat
import Firebase

struct ChannelView: View {
    
    @EnvironmentObject var streamData: StreamViewModel
    @AppStorage("userName") var storedUser = ""
    @AppStorage("log_Status") var logStatus = false
    
    
    var body: some View {
       
        // Channel View...
        ScrollView(.vertical, showsIndicators: false, content: {
            
            VStack(spacing: 20){
                
                if let channels = streamData.channels{
                    
                    ForEach(channels,id: \.channel){listner in
                     
                        NavigationLink(
                            destination: ChatView(listner: listner),
                            label: {
                                
                                ChannelRowView(listner: listner)
                            })
                    }
                }
                else{
                    // Progress View....
                    ProgressView()
                        .padding(.top,20)
                }
            }
            .padding()
        })
        .navigationTitle("Channel")
        // Navigation Bar Buttons....
        .toolbar(content: {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button(action: {
                    streamData.channels = nil
                    streamData.fetchAllChannels()
                }, label: {
                    Image(systemName: "arrow.clockwise.circle.fill")
                })
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button(action: {
                    withAnimation{streamData.createNewChannel.toggle()}
                }, label: {
                    Image(systemName: "square.and.pencil")
                })
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                
                Button(action: {
                    // Logging Out...
                    logStatus = false
                    storedUser = ""
                    try! Auth.auth().signOut()
                }, label: {
                    Image(systemName: "power")
                })
            }
        })
        .onAppear(perform: {
            streamData.fetchAllChannels()
        })
    }
}

struct ChannelView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelView()
    }
}

// Channel Row View....
struct ChannelRowView: View {
    
    @StateObject var listner: ChatChannelController.ObservableObject
    
    @EnvironmentObject var streamData: StreamViewModel
    
    var body: some View{
        
        VStack(alignment: .trailing, spacing: 5, content: {
            
            HStack(spacing: 12){
                
                let channel = listner.controller.channel!
                
                Circle()
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 55, height: 55)
                    .overlay(
                    
                        // First Letter as Image...
                        Text("\(String(channel.cid.id.first!))")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    )
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text(channel.cid.id)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    // Last Msg...
                    if let lastMsg = channel.latestMessages.first{
                        
                        // showing the last user name...
                        (
                        
                            Text(lastMsg.isSentByCurrentUser ? "Me: " : "\(lastMsg.author.id): ")
                            
                            +
                            
                                Text(lastMsg.text)
                        )
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(1)

                    }
                })
                
                Spacer(minLength: 10)
                
                // Time...
                if let time = channel.latestMessages.first?.createdAt{
                    Text(time,style: checkIsDateToday(date: time) ? .time : .date)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
                .padding(.leading,60)
        })
        .onAppear(perform: {
            // watching the updates on channel..
            listner.controller.synchronize()
        })
        .onChange(of: listner.controller.channel?.latestMessages.first?.text, perform: { value in
            // firing sort...
            print("sort channels...")
            sortChannels()
        })
    }
    
    // checking if msg is from today then display time else display date...
    func checkIsDateToday(date: Date)->Bool{
        
        let calender = Calendar.current
        
        if calender.isDateInToday(date){
            return true
        }
        else{
            return false
        }
    }
    
    func sortChannels(){
        
        let result = streamData.channels.sorted { (ch1, ch2) -> Bool in
            
            if let date1 = ch1.channel?.latestMessages.first?.createdAt{
                
                if let date2 = ch2.channel?.latestMessages.first?.createdAt{
                    
                    return date1 > date2
                }
                else{
                    return false
                }
            }
            else{
                return false
            }
        }
        
        streamData.channels = result
    }
}

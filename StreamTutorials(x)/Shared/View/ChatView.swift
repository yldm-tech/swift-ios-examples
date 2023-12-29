//
//  ChatView.swift
//  Stream Tutorials
//
//  Created by Balaji on 23/03/21.
//

import SwiftUI
import StreamChat

struct ChatView: View {
    
    // since its observing object so its automaticlly observing and refreshing....
    @StateObject var listner: ChatChannelController.ObservableObject
    
    //Message
    @State var message = ""
    
    // Color Scheme
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        
        let channel = listner.controller.channel!
        
        VStack{
            
            // scrollView Reader for Scrolling down...
            ScrollViewReader{reader in
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    // Lazy Stack For Lazy Loading...
                    LazyVStack(alignment: .center, spacing: 15, content: {

                        ForEach(listner.messages.reversed(),id: \.self){msg in
                            
                            // Message Row...
                            MessageRowView(messsage: msg)
                        }
                    })
                    .padding()
                    .padding(.bottom,10)
                    .id("MSG_VIEW")
                })
                .onChange(of: listner.messages, perform: { value in
                    
                    withAnimation{
                        reader.scrollTo("MSG_VIEW",anchor: .bottom)
                    }
                })
                .onAppear(perform: {
                    // scrolling to bottom...
                    reader.scrollTo("MSG_VIEW",anchor: .bottom)
                })
            }
            
            // TextField And Send Button....
            HStack(spacing: 10){
                
                TextField("Message", text: $message)
                    .modifier(ShadowModifier())
                
                Button(action: sendMessage, label: {
                    Image(systemName: "paperplane.fill")
                        .padding(10)
                        .background(Color.primary)
                        .foregroundColor(scheme == .dark ? .black : .white)
                        .clipShape(Circle())
                })
                // Disabling Button when no txt typed...
                .disabled(message == "")
                .opacity(message == "" ? 0.5 : 1)
            }
            .padding(.horizontal)
            .padding(.bottom,8)
        }
        .navigationTitle(channel.cid.id)
    }
    
    // sending Message...
    func sendMessage(){
        
        // since we created a channel for messaging...
        
        let channelID = ChannelId(type: .messaging, id: listner.channel?.cid.id ?? "")
        
        ChatClient.shared.channelController(for: channelID).createNewMessage(text: message){result in
            
            switch result{
            
            case .success(let id):
                print("success = \(id)")
                
            case .failure(let error):
                // show error...
                print(error.localizedDescription)
            }
        }
        
        //clearing Msg Field...
        message = ""
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




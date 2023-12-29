//
//  MessageRowView.swift
//  Stream Tutorials
//
//  Created by Balaji on 24/03/21.
//

import SwiftUI
import StreamChat

struct MessageRowView: View {
    
    var messsage: ChatMessage
    
    var body: some View{
        
        HStack{

            if messsage.isSentByCurrentUser{
                Spacer()
            }
            
            HStack(alignment: .bottom,spacing: 10){
                
                if !messsage.isSentByCurrentUser{
                    UserView(message: messsage)
                        .offset(y: 10.0)
                }
                
                // Msg With Chat Bubble...
                VStack(alignment: messsage.isSentByCurrentUser ? .trailing : .leading, spacing: 6, content: {
                    
                    Text(messsage.text)
                    
                    Text(messsage.createdAt,style: .time)
                        .font(.caption)
                })
                .padding([.horizontal,.top])
                .padding(.bottom,8)
                // Current User color is blue and opposite user color is gray...
                .background(messsage.isSentByCurrentUser ? Color.blue : Color.gray.opacity(0.4))
                .clipShape(ChatBubble(corners: messsage.isSentByCurrentUser ? [.topLeft,.topRight,.bottomLeft] : [.topLeft,.topRight,.bottomRight]))
                .foregroundColor(messsage.isSentByCurrentUser ? .white : .primary)
                .frame(width: UIScreen.main.bounds.width - 150,alignment: messsage.isSentByCurrentUser ? .trailing : .leading)
                

                if messsage.isSentByCurrentUser{
                    UserView(message: messsage)
                        .offset(y: 10.0)
                }
            }
            
            if !messsage.isSentByCurrentUser{
                Spacer()
            }
        }
    }
}

// User View...

struct UserView: View {
    
    var message: ChatMessage
    
    var body: some View{
        
        Circle()
            .fill(message.isSentByCurrentUser ? Color.blue : Color.gray.opacity(0.4))
            .frame(width: 40, height: 40)
            .overlay(
            
                // Author First Letter...
                Text("\(String(message.author.id.first!))")
                    .fontWeight(.semibold)
                    .foregroundColor(message.isSentByCurrentUser ? .white : .primary)
            )
        // COntext Menu For Showing User Name And Last Active Status...
            .contextMenu(menuItems: {

                Text("\(message.author.id)")
                    
                if message.author.isOnline{
                    Text("Status: Online")
                }
                else{
                    Text(message.author.lastActiveAt ?? Date(),style: .time)
                }
            })
    }
}

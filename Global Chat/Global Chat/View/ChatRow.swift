//
//  ChatRow.swift
//  Global Chat
//
//  Created by Balaji on 12/09/20.
//

import SwiftUI

struct ChatRow: View {
    var chatData : MsgModel
    @AppStorage("current_user") var user = ""
    var body: some View {
        
        HStack(spacing: 15){
            
            // NickName View...
            
            if chatData.user != user{
                
                NickName(name: chatData.user)
            }
            
            if chatData.user == user{Spacer(minLength: 0)}
            
            VStack(alignment: chatData.user == user ? .trailing : .leading, spacing: 5, content: {
                
                Text(chatData.msg)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("Color"))
                // Custom Shape...
                    .clipShape(ChatBubble(myMsg: chatData.user == user))
                
                Text(chatData.timeStamp,style: .time)
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(chatData.user != user ? .leading : .trailing , 10)
            })
            
            if chatData.user == user{
                
                NickName(name: chatData.user)
            }
            
            if chatData.user != user{Spacer(minLength: 0)}
        }
        .padding(.horizontal)
        // For SCroll Reader....
        .id(chatData.id)
    }
}

struct NickName : View {
    
    var name : String
    @AppStorage("current_user") var user = ""
    
    var body: some View{
        
        Text(String(name.first!))
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .frame(width: 50, height: 50)
            .background((name == user ? Color.blue : Color.green).opacity(0.5))
            .clipShape(Circle())
            // COntext menu For Name Display...
            .contentShape(Circle())
            .contextMenu{
                
                Text(name)
                    .fontWeight(.bold)
            }
    }
}

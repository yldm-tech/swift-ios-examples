//
//  Login.swift
//  SharedLogin (iOS)
//
//  Created by Balaji on 11/01/21.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var homeData : LoginViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 18, content: {
            Text("Please Login")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Label(
                title: { TextField("Enter Email", text: $homeData.email)
                    .textFieldStyle(PlainTextFieldStyle())
                },
                icon: { Image(systemName: "envelope")
                    .frame(width: 30)
                    .foregroundColor(.gray)
                })
            
            Divider()
            
            Label(
                title: { SecureField("Password", text: $homeData.password)
                    .textFieldStyle(PlainTextFieldStyle())
                },
                icon: { Image(systemName: "lock")
                    .frame(width: 30)
                    .foregroundColor(.gray)
                })
                .overlay(
                    Button(action: {}, label: {
                        Image(systemName: "eye")
                            .foregroundColor(.gray)
                    })
                    .buttonStyle(PlainButtonStyle())
                    ,alignment: .trailing
                )
            
            Divider()
            
            HStack{
                Button(action: {}, label: {
                    Text("Forgot details?")
                        .font(.caption)
                        .fontWeight(.bold)
                })
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                Button(action: {
                    /// Pushing to register Page
                    withAnimation{
                        homeData.clearData()
                        homeData.gotoRegister.toggle()
                    }
                }, label: {
                    Text("Create account")
                        .font(.caption)
                        .fontWeight(.bold)
                })
                .buttonStyle(PlainButtonStyle())
            }
            .foregroundColor(.gray)
        })
        .modifier(LoginViewModifier())
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

//
//  Login.swift
//  MacEmailAuth (iOS)
//
//  Created by Balaji on 31/03/21.
//

import SwiftUI

struct Login: View {
    @StateObject var loginData = LoginViewModel()
    var body: some View {
        
        let width = getRect().width / 1.6
        
        HStack(spacing: 0){
            
            VStack(alignment: .leading, spacing: 18, content: {
                
                // Login View....
                
                Text("Welcome to \nWallpapers")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                
                // Login...
                if !loginData.isNewUser{
                    
                    // Custom TextFields...
                    CustomTextField(value: $loginData.userName, hint: "User Name")
                    
                    CustomTextField(value: $loginData.password, hint: "Password")
                    
                    // Foreget Password Button...
                    Button(action: loginData.resetPassword, label: {
                        Text("Forget Password?")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                    })
                    .disabled(loginData.userName == "")
                    .opacity(loginData.userName == "" ? 0.8 : 1)
                    
                    // Actions...
                    Button(action: loginData.loginUser, label: {
                        Text("Login")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    })
                    .padding(.top,10)
                    // disabling when no data ...
                    .disabled(loginData.userName == "" || loginData.password == "")
                    .opacity((loginData.userName == "" || loginData.password == "") ? 0.6 : 1)
                    
                    Button(action: {
                        // Registering New User.....
                        withAnimation{loginData.isNewUser.toggle()}
                    }, label: {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    })
                }
                else{
                    
                    // Back Button...
                    
                    Button(action: {
                        withAnimation{loginData.isNewUser.toggle()}
                    }, label: {

                        Label(
                            title: { Text("Back")
                                .fontWeight(.semibold)
                            },
                            icon: { Image(systemName: "chevron.left") })
                            .font(.caption)
                            .foregroundColor(.gray)
                    })
                    
                    // Custom TextFields...
                    CustomTextField(value: $loginData.registerUserName, hint: "User Name")
                    
                    CustomTextField(value: $loginData.resiterPassword, hint: "Password")
                    
                    CustomTextField(value: $loginData.reEnterPassword, hint: "Re-Enter Password")

                    // Actions...
                    Button(action: loginData.registerUser, label: {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    })
                    .padding(.top,10)
                    // disabling when no data ...
                    .disabled(loginData.registerUserName == "" || loginData.resiterPassword == "" || loginData.reEnterPassword == "")
                    .opacity((loginData.registerUserName == "" || loginData.resiterPassword == "" || loginData.reEnterPassword == "") ? 0.6 : 1)
                }
                
            })
            .textFieldStyle(PlainTextFieldStyle())
            .buttonStyle(PlainButtonStyle())
            .padding()
            .padding(.horizontal)
            .offset(y: -50)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .zIndex(1)
            // Since Image is having many problems in SwiftUI....
            // it overlay on view actions......
            
            // Image....
            
            Image("pic")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width / 1.6)
                .clipped()
                .zIndex(0)
        }
        .ignoresSafeArea()
        .overlay(ZStack{if loginData.isLoading{LoadingScreen()}})
        .frame(width: width, height: getRect().height - 180)
        // ERror...
        .alert(isPresented: $loginData.error, content: {
            Alert(title: Text("Message"), message: Text(loginData.errorMsg), dismissButton: .destructive(Text("Ok"), action: {
                // Closing Loading SCreen...
                withAnimation{loginData.isLoading = false}
            }))
        })
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

// Extending View to get Screen Rect...

extension View{
    
    func getRect()->CGRect{
        
        return NSScreen.main!.visibleFrame
    }
}

struct CustomTextField: View {
    
    @Binding var value: String
    var hint: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6, content: {
            Text(hint)
                .font(.caption)
                .foregroundColor(.gray)
            
            ZStack{
                
                if hint == "User Name"{
                    TextField(hint == "User Name" ? "kaviya@gmail.com" : "**********", text: $value)
                }
                else{
                    SecureField("**********", text: $value)
                }
            }
                .padding(.vertical,10)
                .padding(.horizontal)
                .background(Color.white.opacity(0.13))
                .cornerRadius(8)
            .colorScheme(.dark)
        })
    }
}

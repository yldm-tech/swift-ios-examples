//
//  Login.swift
//  Login
//
//  Created by Balaji on 01/09/21.
//

import SwiftUI
import AuthenticationServices

struct Login: View {
    // ViewModel...
    @StateObject var loginData = LoginViewModel()
    
    // Skip Button..
    @Binding var skip: Bool
    
    var body: some View {
        
        VStack(spacing: 15){
            
            Text("Let's start by\ncreating your account")
                .font(.title)
                .foregroundColor(.black)
                .padding(.horizontal)
                .padding(.top)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            // Custom Text Fields...
            // See my Material TextField Video....
            
            VStack(spacing: 30){
                
                CustomTextField(hint: "Username", text: $loginData.username)
                
                CustomTextField(hint: "Email Address", text: $loginData.email)
                
                CustomTextField(hint: "Phone Number", text: $loginData.phNumber)
                
                CustomTextField(hint: "About You", text: $loginData.about)
            }
            .padding(.horizontal)
            .padding(.top)
            
            HStack(spacing: 12){
                
                // SignUp Button...
                Button {
                    loginData.sendOTP()
                } label: {
                    Text("Signup With OTP")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.black)
                        .cornerRadius(12)
                }
                
                // Signin With Apple Custom Button...

                Image(systemName: "applelogo")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 55,height: 55)
                    .background(Color.black)
                    .cornerRadius(12)
                // Just overlaying Signin Apple button...
                // So that it will work when tap...
                    .overlay(
                    
                        // Apple Sign In...
                        // See my Apple Sign in Video for more depth....
                        SignInWithAppleButton(onRequest: { request in
                            
                            // requesting paramertes from apple login...
                            loginData.nonce = randomNonceString()
                            request.requestedScopes = [.email,.fullName]
                            request.nonce = sha256(loginData.nonce)
                            
                        }, onCompletion: { result in
                            
                            // getting error or success...
                            
                            switch result{
                            case .success(let user):
                                print("success")
                                // do Login With Firebase...
                                guard let credential = user.credential as? ASAuthorizationAppleIDCredential else{
                                    print("error with firebase")
                                    return
                                }
                                loginData.authenticate(credential: credential)
                            case.failure(let error):
                                print(error.localizedDescription)
                            }
                            
                        })
                        .signInWithAppleButtonStyle(.whiteOutline)
                        .frame(width: 55,height: 55)
                        .opacity(0.02)
                        
                    )

            }
            .padding()
            .opacity(!loginData.isLoading ? 1 : 0)
            .overlay(
            
                ProgressView()
                    .opacity(loginData.isLoading ? 1 : 0)
            )
            // For testing...
            .disabled(!isFilled())
            .opacity(isFilled() ? 1 : 0.6)
            
            Spacer(minLength: 0)
            
            HStack{
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Save and Continue")
                        .fontWeight(.bold)
                    
                    Text("Skip for Later")
                        .font(.callout)
                        .fontWeight(.light)
                }
                
                Spacer(minLength: 0)
                
                // Button...
                Button {
                    withAnimation{
                        skip.toggle()
                    }
                } label: {
                    Image(systemName: "arrow.right")
                        .font(.title2)
                        .foregroundColor(.black)
                        .frame(width: 50, height: 50)
                        .background(
                        
                            Circle()
                                .fill(Color("Yellow"))
                            // black border..
                                .padding(2)
                                .background(
                                
                                    Circle()
                                        .strokeBorder(.black,lineWidth: 3)
                                )
                        )
                }

            }
            .padding()
            .background(
            
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("Purple"))
                    .padding(2)
                // Black Border...
                    .background(
                    
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(.black,lineWidth: 3)
                    )
                    .ignoresSafeArea(.container, edges: .bottom)
            )
        }
        // alert...
        .alert(isPresented: $loginData.showAlert) {
            
            Alert(title: Text("Message"), message: Text(loginData.alertMSG), dismissButton: .destructive(Text("Ok"), action: {
                loginData.isLoading = false
            }))
        }
    }
    
    // disabling field until all data is filled....
    func isFilled()->Bool{
        if loginData.email == "" || loginData.username == "" || loginData.about == "" || loginData.phNumber == ""{
            return false
        }
        return true
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  LoginViewModel.swift
//  Stream Tutorials
//
//  Created by Balaji on 11/05/21.
//

import SwiftUI
import Firebase
import StreamChat
import JWTKit

class LoginViewModel: ObservableObject {

    // Logi Properties...
    @Published var countryCode = ""
    @Published var phNumber = ""
    
    // Alert...
    @Published var showAlert = false
    @Published var errorMsg = ""
    
    // Verification ID
    @Published var ID = ""
    
    // Loading...
    @Published var isLoading = false
    
    @AppStorage("log_Status") var logStatus = false
    @AppStorage("userName") var storedUser = ""
    @Published var newUser = false
    
    func verifyUser(){
        
        withAnimation{isLoading = true}
        
        // Undo this if testing with real devices or real ph Numbers...
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        // Sending Otp And Verifying user...
        PhoneAuthProvider.provider().verifyPhoneNumber("+\(countryCode + phNumber)", uiDelegate: nil) { ID, err in
            
            if let error = err{
                self.errorMsg = error.localizedDescription
                self.showAlert.toggle()
                return
            }
            
            self.ID = ID!
            self.alertWithTF()
        }
    }
    
    // Alert With TextField For OTP Code...
    func alertWithTF(){
        
        let alert = UIAlertController(title: "Verification", message: "Enter OTP Code", preferredStyle: .alert)
        
        alert.addTextField { txt in
            txt.placeholder = "123456"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            
            if let code = alert.textFields?[0].text{
                self.LoginUser(code: code)
            }
            else{
                self.reportError()
            }
            
        }))
        
        // presenting Alert View...
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    // Loggin in User...
    func LoginUser(code: String){
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.ID, verificationCode: code)
        
        Auth.auth().signIn(with: credential) { result, err in
            if let error = err{
                self.errorMsg = error.localizedDescription
                self.showAlert.toggle()
                return
            }
            
            // user Successfully Logged In....
            print("success")
            
            // Verifying if user is already in stream SDk or Not...
            
            // for that we need to intialize the stream sdk with JWT Tokens...
            // AKA known as Authenticatiog with stream SDK....
            
            // generating JWT Token...
            
            let signers = JWTSigners()
            signers.use(.hs256(key: secretKey.data(using: .utf8)!))
            
            // Creating Payload and inserting Userd ID to generate Token..
            // Here User ID will be Firebase UID....
            // Since its Unique...
            
            guard let uid = Auth.auth().currentUser?.uid else{
                self.reportError()
                return
            }
            
            let payload = PayLoad(user_id: uid)
            
            // generating Token...
            do{
                
                let jwt = try signers.sign(payload)
                
                print(jwt)
                
                let config = ChatClientConfig(apiKeyString: APIKey)
                
                let tokenProvider = TokenProvider.closure { client, completion in
                    
                    guard let token = try? Token(rawValue: jwt) else{
                        self.reportError()
                        return
                    }
                    
                    completion(.success(token))
                }
                
                ChatClient.shared = ChatClient(config: config, tokenProvider: tokenProvider)
                
                // Reloading ChatClient...
                ChatClient.shared.currentUserController().reloadUserIfNeeded { err in
                    
                    if let _ = err{
                        self.reportError()
                        return
                    }
                    
                    // Simple Trick to find the user is already signed up..
                    // Just Checking the user having name...
                    // if yes then it means the user already signed up..
                    // else new user...
                    
                    if let name = ChatClient.shared.currentUserController().currentUser?.name{
                        
                        withAnimation{
                            self.storedUser = name
                            self.logStatus = true
                            self.isLoading = false
                        }
                    }
                    else{
                        
                        withAnimation{
                            self.newUser = true
                            self.isLoading = false
                        }
                    }
                }
            }
            catch{
                print(error.localizedDescription)
            }
            
        }
    }
    
    // Reporting Error...
    func reportError(){
        self.errorMsg = "Please try again later !!!"
        self.showAlert.toggle()
    }
}

struct PayLoad: JWTPayload,Equatable {
    
    enum CodingKeys: String,CodingKey {
        case user_id
    }
    
    var user_id: String
    
    func verify(using signer: JWTSigner) throws {
        
    }
}

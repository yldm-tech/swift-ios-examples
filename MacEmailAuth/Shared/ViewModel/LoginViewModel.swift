//
//  LoginViewModel.swift
//  MacEmailAuth (iOS)
//
//  Created by Balaji on 31/03/21.
//

import SwiftUI
import Firebase

class LoginViewModel: ObservableObject {

    // Login Properties...
    @Published var userName = ""
    @Published var password = ""
    
    // Register Properties...
    @Published var isNewUser = false
    @Published var registerUserName = ""
    @Published var resiterPassword = ""
    @Published var reEnterPassword = ""
    
    // Loading SCreen...
    @Published var isLoading = false
    
    // Error
    @Published var errorMsg = ""
    @Published var error = false
    
    // Log Status...
    @AppStorage("log_Status") var status = false
    
    func loginUser(){
        
        // Loading Screen....
        withAnimation{isLoading = true}
        
        // Loggin In User....
        Auth.auth().signIn(withEmail: userName, password: password) { [self] (result, err) in
            
            if let error = err{
                // Promoting Error..
                errorMsg = error.localizedDescription
                self.error.toggle()
                return
            }
            
            guard let _ = result else{
                errorMsg = "Please try again Later !!!"
                error.toggle()
                return
            }
            
            // Success....
            print("SUccess")
            // Promoting User Success Msg..
            errorMsg = "Logged Successfully !!!"
            error.toggle()
            withAnimation{status = true}
        }
    }
    
    func resetPassword(){
        
        withAnimation{isLoading = true}
        
        Auth.auth().sendPasswordReset(withEmail: userName) {[self] (err) in
            
            if let error = err{
                // Promoting Error..
                errorMsg = error.localizedDescription
                self.error.toggle()
                return
            }
            
            // Promoting User Success Msg..
            errorMsg = "Reset Link Sent Successfully !!!"
            error.toggle()
        }
    }
    
    func registerUser(){
        
        // Checking Password Match...
        if reEnterPassword == resiterPassword{
            
            withAnimation{isLoading = true}
            
            Auth.auth().createUser(withEmail: registerUserName, password: reEnterPassword) {[self] (result, err) in
                
                if let error = err{
                    // Promoting Error..
                    errorMsg = error.localizedDescription
                    self.error.toggle()
                    return
                }
                
                guard let _ = result else{
                    errorMsg = "Please try again Later !!!"
                    error.toggle()
                    return
                }
                
                // Success....
                print("SUccess")
                // Promoting User Success Msg..
                errorMsg = "Account Created Successfully !!!"
                error.toggle()
                // Promoting user back...
                withAnimation{isNewUser = false}
            }
        }
        else{
            errorMsg = "Password Mismatch"
            error.toggle()
        }
    }
}

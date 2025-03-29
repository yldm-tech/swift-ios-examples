//
//  LoginViewModel.swift
//  LoginViewModel
//
//  Created by Balaji on 01/09/21.
//

import SwiftUI
import Firebase
import CryptoKit
import AuthenticationServices

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var phNumber = ""
    @Published var about = ""
    
    @Published var isLoading = false
    
    // Alert...
    @Published var showAlert = false
    @Published var alertMSG = ""
    
    // Send Otp...
    
    // Log Status...
    @AppStorage("log_Status") var log_Status = false
    
    // For Apple Signin...
    @Published var nonce = ""
    
    func sendOTP(){
        
        // sample Testing...
        // disbale it when testing with real numbers...
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        // Use extra textfield or use Locale to get the country Code...
        // Im simply testing with testing numbers....
        PhoneAuthProvider.provider().verifyPhoneNumber("+1\(phNumber)", uiDelegate: nil) { CODE, err in
            if let error = err{
                self.handleError(error: error)
                return
            }
            
            // else Promting OTP...
            self.OTPView(code: CODE ?? "")
        }
    }
    
    func OTPView(code: String){
        
        // Alert With TextField...
        let alert = UIAlertController(title: "Verify Phone", message: "Enter OTP", preferredStyle: .alert)
        
        alert.addTextField { txt in
            txt.placeholder = "123456"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Verify", style: .default, handler: { _ in
            
            if let otp = alert.textFields?[0].text{
                self.verifyOTP(code: code, otp: otp)
            }
        }))
        
        // displaying alert...
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return
        }
        
        scene.windows.last?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    // verify OTP...
    func verifyOTP(code: String,otp: String){
        
        // Auth with Firebase...
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: code, verificationCode: otp)
        
        isLoading = true
        
        Auth.auth().signIn(with: credential) { result, err in
            
            if let error = err{
                self.handleError(error: error)
                return
            }
            
            withAnimation{
                self.log_Status = true
            }
        }
    }
    
    func handleError(error: Error){
        
        alertMSG = error.localizedDescription
        showAlert.toggle()
    }
    
    func authenticate(credential: ASAuthorizationAppleIDCredential){
        
        // getting Token....
        guard let token = credential.identityToken else{
            print("error with firebase")
            
            return
        }
        
        // Token String...
        guard let tokenString = String(data: token, encoding: .utf8) else{
            print("error with Token")
            return
        }
        
        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString,rawNonce: nonce)
        
        isLoading = true
        
        Auth.auth().signIn(with: firebaseCredential) { (result, err) in
            
            if let error = err{
                self.handleError(error: error)
                return
            }
            
            // User Successfully Logged Into Firebase...
            print("Logged In Success")
            // Directing User TO Home Page....
            withAnimation(.easeInOut){
                self.log_Status = true
            }
        }
    }
}


// helpers for Apple Login With Firebase...

 func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashedData = SHA256.hash(data: inputData)
  let hashString = hashedData.compactMap {
    return String(format: "%02x", $0)
  }.joined()

  return hashString
}

 func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  let charset: Array<Character> =
      Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
  var result = ""
  var remainingLength = length

  while remainingLength > 0 {
    let randoms: [UInt8] = (0 ..< 16).map { _ in
      var random: UInt8 = 0
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
      if errorCode != errSecSuccess {
        fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
      }
      return random
    }

    randoms.forEach { random in
      if remainingLength == 0 {
        return
      }

      if random < charset.count {
        result.append(charset[Int(random)])
        remainingLength -= 1
      }
    }
  }

  return result
}

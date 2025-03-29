//
//  Stream_TutorialsApp.swift
//  Shared
//
//  Created by Balaji on 23/03/21.
//

import SwiftUI
import StreamChat
import Firebase
import JWTKit

@main
struct Stream_TutorialsApp: App {
    
    // calling Delegate...
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// Delegate...
class AppDelegate: NSObject,UIApplicationDelegate{
    
    // diffent way of intializing the Stream...
    
    @AppStorage("userName") var storedUser = ""
    @AppStorage("log_Status") var logStatus = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Intializing Firebase...
        FirebaseApp.configure()

        // if user already logged in...
        if logStatus{
            
            // Reloading user if logged in...
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
                return true
            }
            
            let payload = PayLoad(user_id: uid)
            
            // generating Token...
            do{
                
                let jwt = try signers.sign(payload)
                
                print(jwt)
                
                let config = ChatClientConfig(apiKeyString: APIKey)
                
                let tokenProvider = TokenProvider.closure { client, completion in
                    
                    guard let token = try? Token(rawValue: jwt) else{
                        return
                    }
                    
                    completion(.success(token))
                }
                
                ChatClient.shared = ChatClient(config: config, tokenProvider: tokenProvider)
                ChatClient.shared.currentUserController().reloadUserIfNeeded()
                
            }
            catch{
                print(error.localizedDescription)
            }
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
}

// stream API...
extension ChatClient{
    static var shared: ChatClient!
}

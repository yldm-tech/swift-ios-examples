//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 23/03/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var streamData = StreamViewModel()
    @StateObject var model = LoginViewModel()
    @AppStorage("log_Status") var logStatus = false
    
    var body: some View {
        
        NavigationView{
            
            if !logStatus{
                if model.newUser{
                    
                    Login()
                        .environmentObject(streamData)
                        .navigationTitle("Register")
                }
                else{
                    OtpLogin()
                        .environmentObject(model)
                        .navigationTitle("Login")
                }
            }
            else{
                
                ChannelView()
                    
            }
        }
        // Since we have differnt alerts...
        .background(
        
            ZStack{
                Text("")
                    .alert(isPresented: $model.showAlert, content: {
                        
                        Alert(title: Text("Message"), message: Text(model.errorMsg), dismissButton: .destructive(Text("Ok"), action: {
                            
                            withAnimation{
                                model.isLoading = false
                            }
                        }))
                    })
                
                Text("")
                    .alert(isPresented: $streamData.error, content: {
                        
                        Alert(title: Text("Message"), message: Text(streamData.errorMsg), dismissButton: .destructive(Text("Ok"), action: {
                            
                            withAnimation{
                                streamData.isLoading = false
                            }
                        }))
                    })
            }
        )
        .overlay(
            ZStack{
                
                
                // New Channel View....
                if streamData.createNewChannel{CreateNewChannel()}
                
                // Lodaing Screen...
                if model.isLoading || streamData.isLoading{LoadingScreen()}
            }
        )
        .environmentObject(streamData)
        .onChange(of: logStatus, perform: { value in
            if logStatus{
                model.newUser = false
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

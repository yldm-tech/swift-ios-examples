//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 07/07/21.
//

// Code is Just Clearly Explaining how to use with/without State Updates....

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView{
            
            VStack{
             
                NavigationLink {
                    HomeWithoutStateUpdate()
                        .navigationTitle("Without State Update")
                } label: {
                    Text("Without State Update")
                }
                
                NavigationLink {
                    HomeWithStateUpdate()
                        .navigationTitle("With State Update")
                } label: {
                    Text("With State Update")
                }
                .padding(10)
            }
            .navigationTitle("Half Modal Sheet")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Eg 1 Without State Update
struct HomeWithoutStateUpdate: View{
    
    @State var showSheet: Bool = false
    
    var body: some View{
        
        Button {
            showSheet.toggle()
        } label: {
            
            Text("Present Sheet")
        }
        .halfSheet(showSheet: $showSheet) {
            
            // Your Half Sheet View....
            ZStack{
                
                Color.orange
                
                VStack{
                    
                    Text("Hello iJustine")
                        .font(.title.bold())
                        .foregroundColor(.white)
                    
                    Button {
                        showSheet.toggle()
                    } label: {
                        Text("Close From Sheet")
                            .foregroundColor(.white)
                    }
                    .padding(10)

                }
            }
            .ignoresSafeArea()
        } onEnd: {
            
            print("Dismissed")
        }
    }
}

// Eg 1 With State Update
struct HomeWithStateUpdate: View{
    
    @StateObject var homeModel = HomeModel()
    
    var body: some View{
        
        Button {
            homeModel.showSheet.toggle()
        } label: {
            
            Text("Present Sheet")
        }
        .halfSheet(showSheet: $homeModel.showSheet) {
            
            // For View State Updates
            // Nothing Just Create a new View and Call it here, Instead of defining in this block
            // Eg VStack{Text("Hello")} -> Wrong
            // Eg Home() -> Right
            SheetView()
                .environmentObject(homeModel)
            
            
        } onEnd: {
            
            print("Dismissed")
        }
    }
}

struct SheetView: View{
    
    @EnvironmentObject var homeModel: HomeModel
    
    var body: some View{
        
        // Your Half Sheet View....
        ZStack{
            
            homeModel.tapped ? Color.blue : Color.orange
            
            VStack{
                
                Text(homeModel.tapped ? "Tap Me Again" : "Tap Me")
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .onTapGesture {
                        homeModel.tapped.toggle()
                    }
                
                Button {
                    homeModel.showSheet.toggle()
                } label: {
                    Text("Close From Sheet")
                        .foregroundColor(.white)
                }
                .padding(10)

            }
        }
        .ignoresSafeArea()
    }
}

class HomeModel: ObservableObject{
    @Published var showSheet = false
    @Published var tapped = false
}

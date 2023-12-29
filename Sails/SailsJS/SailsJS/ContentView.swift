//
//  ContentView.swift
//  SailsJS
//
//  Created by Balaji on 31/08/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        NavigationView{
            
            Home()
                .navigationTitle("Sails JS")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @StateObject var data = Server()
    
    var body: some View{
        
        VStack{
            
            if data.users.isEmpty{
                
                if data.noData{Text("No Users Found")}
                else{ProgressView()}
            }
            else{
                
                List{
                    
                    ForEach(data.users,id: \.id){user in
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text(user.username)
                                .fontWeight(.bold)
                            
                            Text(user.password)
                                .font(.caption)
                        }
                    }
                    .onDelete { (indexset) in
                        
                        indexset.forEach { (index) in
                            data.deleteUser(id: data.users[index].id)
                        }
                    }
                }
            }
        }
        // .navigationbar items is decrepted....
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button(action: data.newUser) {
                    
                    Text("Create")
                }
            }
        }
    }
}

class Server : ObservableObject{
    
    @Published var users : [User] = []
    let url = "http://localhost:1337/user"
    @Published var noData = false
    
    init() {
        
        getUsers()
    }
    
    func setUser(username : String,password:String){
        
        let session = URLSession(configuration: .default)
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "POST"
        
        // adding header Values....
        
        request.addValue(username, forHTTPHeaderField: "username")
        request.addValue(password, forHTTPHeaderField: "password")
        
        
        session.dataTask(with: request) { (data, _, err) in
            
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            guard let response = data else{return}
            
            let status = String(data: response, encoding: .utf8) ?? ""
            
            if status == "PASS"{self.getUsers()}
            else{print("Failed To Write...")}
        }
        .resume()
    }
    
    func getUsers(){
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { (data, _, err) in
            
            if err != nil{
                print(err!.localizedDescription)
                self.noData.toggle()
                return
            }
            
            guard let response = data else{return}
            
            let users = try! JSONDecoder().decode([User].self, from: response)
            
            DispatchQueue.main.async {
                
                self.users = users
                if users.isEmpty{self.noData.toggle()}
            }
        }
        .resume()
    }
    
    func deleteUser(id: Int){
        
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "DELETE"
        
        // if simply destroy means it will delete all data....
        
        request.addValue("\(id)", forHTTPHeaderField: "id")
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { (data, _, err) in
            
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            
            guard let response = data else{return}
            
            let status = String(data: response, encoding: .utf8) ?? ""
            
            if status == "PASS"{
                DispatchQueue.main.async {
                    // removing data in List...
                    self.users.removeAll { (user) -> Bool in
                        
                        return user.id == id
                    }
                }
            }
            else{print("Failed To Delete")}
        }
        .resume()
    }
    
    func newUser(){
        
        // Alert View...
        
        let alert = UIAlertController(title: "New User", message: "Create A Account", preferredStyle: .alert)
        
        alert.addTextField { (user) in
            user.placeholder = "Username"
        }
        alert.addTextField { (pass) in
            
            pass.placeholder = "Password"
            pass.isSecureTextEntry = true
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { (_) in
            
            self.setUser(username: alert.textFields![0].text!, password: alert.textFields![1].text!)
        }))
        
        // presenting...
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
}

// Model...

struct User : Decodable {
    
    // it will be automatically created....
    var id : Int
    var username : String
    var password : String
}

// Going to create New Sail Js App...
// Created Successfully....
// Going to create Route For /user....

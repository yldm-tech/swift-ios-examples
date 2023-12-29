//
//  CharactersView.swift
//  Marvel API
//
//  Created by Balaji on 14/03/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharactersView: View {
    @EnvironmentObject var homeData: HomeViewModel
    var body: some View {

        // Navigation View...
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack(spacing: 15){
                    
                    // Search Bar...
                    HStack(spacing: 10){
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search Character", text: $homeData.searchQuery)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(Color.white)
                    // Shadows..
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
                }
                .padding()
                
                if let characters = homeData.fetchedCharacters{
                    
                    if characters.isEmpty{
                        // No results...
                        Text("No Results Found")
                            .padding(.top,20)
                    }
                    else{
                        
                        // Displaying results....
                        ForEach(characters){data in
                            
                            CharacterRowView(character: data)
                        }
                    }
                }
                else{
                    if homeData.searchQuery != ""{
                        // Loading Screem...
                        ProgressView()
                            .padding(.top,20)
                    }
                }
            })
            .navigationTitle("Marvel")
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CharacterRowView: View {
    
    var character: Character
    
    var body: some View{
        
        HStack(alignment: .top,spacing: 15){
            
            WebImage(url: extractImage(data: character.thumbnail))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text(character.name)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(character.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(4)
                    .multilineTextAlignment(.leading)
                
                // Links....
                HStack(spacing: 10){
                    
                    ForEach(character.urls,id: \.self){data in
                        
                        NavigationLink(
                            destination: WebView(url: extractURL(data: data))
                                .navigationTitle(extractURLType(data: data)),
                            label: {
                                Text(extractURLType(data: data))
                            })
                    }
                }
            })
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal)
    }
    
    func extractImage(data: [String: String])->URL{
        
        // combining both and forming image...
        let path = data["path"] ?? ""
        let ext = data["extension"] ?? ""
        
        return URL(string: "\(path).\(ext)")!
    }
    
    func extractURL(data: [String:String])->URL{
        
        let url = data["url"] ?? ""
        
        return URL(string: url)!
    }
    
    func extractURLType(data: [String:String])->String{
        
        let type = data["type"] ?? ""
        
        return type.capitalized
    }
}

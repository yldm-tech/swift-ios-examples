//
//  PopularItemRowView.swift
//  Food App UI (iOS)
//
//  Created by Balaji on 08/04/21.
//

import SwiftUI

struct PopularItemRowView: View {
    var item: Popular
    var body: some View {
        
        VStack(spacing: 8){
            
            Image(systemName: "flame")
                .font(.footnote)
                .foregroundColor(.red)
                .padding(8)
                .background(Color.orange.opacity(0.1))
                .clipShape(Circle())
            // Setting it to right...
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(-10)
            
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: getRect().width / 3)
                .padding(.top,6)
            
            Text(item.title)
                .fontWeight(.bold)
                .padding(.top,20)
            
            Text(item.description)
                .font(.footnote)
                .foregroundColor(.gray)
            
            (
            
                Text("$ ")
                    .font(.footnote)
                    .foregroundColor(Color("pink"))
                +
                    Text(item.price)
                    .font(.title2)
                    .foregroundColor(.black)
            )
            .fontWeight(.bold)
            .padding(.top,8)
        }
        .padding(.horizontal,30)
        .padding(.vertical)
        .background(Color.white)
        .cornerRadius(25)
        // shadows..
        .shadow(color: Color.black.opacity(0.04), radius: 5, x: 5, y: 5)
    }
}

struct PopularItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

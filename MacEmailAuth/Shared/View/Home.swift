//
//  Home.swift
//  MacEmailAuth
//
//  Created by Balaji on 31/03/21.
//

import SwiftUI
import Firebase

struct Home: View {
    
    @AppStorage("log_Status") var status = false
    
    var body: some View {
        
        VStack(spacing: 20){
            
            Text("Logged Successfully !!!")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Button(action: {
                // Log out Function...
                try? Auth.auth().signOut()
                withAnimation{status = false}
            }, label: {
                Text("Log Out")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical,12)
                    .padding(.horizontal,30)
                    .background(Color.blue)
                    .cornerRadius(8)
            })
            .buttonStyle(PlainButtonStyle())
        }
        .frame(width: getRect().width / 1.6, height: getRect().height - 180)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

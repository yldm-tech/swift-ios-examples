//
//  SignUp.swift
//  CarouselAnimated (iOS)
//
//  Created by Balaji on 28/05/21.
//

import SwiftUI

struct SignUp: View {
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    var body: some View {
        VStack{
            
            Text("Sign Up")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("dark"))
                // Letter Spacing...
                .kerning(1.9)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Email And Password....
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text("User Name")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                TextField("ijustine@gmail.com", text: $email)
                // Increasing Font Size And Changing Text Color...
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color("dark"))
                    .padding(.top,5)
                
                Divider()
            })
            .padding(.top,25)
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text("Password")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                SecureField("123456", text: $password)
                // Increasing Font Size And Changing Text Color...
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color("dark"))
                    .padding(.top,5)
                
                Divider()
            })
            .padding(.top,20)
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text("Confirm Password")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                SecureField("123456", text: $confirmPassword)
                // Increasing Font Size And Changing Text Color...
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color("dark"))
                    .padding(.top,5)
                
                Divider()
            })
            .padding(.top,20)
            
            // This line will reduce the use of unwanted hstack and spacers....
            // Try to use this and reduce the code in SwiftUI :)))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top,10)
            
            // Next Button...
            Button(action: {}, label: {
                Image(systemName: "arrow.right")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("dark"))
                    .clipShape(Circle())
                // Shadow...
                    .shadow(color: Color("lightBlue").opacity(0.6), radius: 5, x: 0, y: 0)
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top,10)
        }
        .padding()
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}

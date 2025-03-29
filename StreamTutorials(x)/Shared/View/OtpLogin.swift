//
//  OtpLogin.swift
//  Stream Tutorials
//
//  Created by Balaji on 11/05/21.
//

import SwiftUI

struct OtpLogin: View {
    @EnvironmentObject var model : LoginViewModel
    var body: some View {
        
        VStack{
            
            Image("logo")
                .padding(20)
            
            HStack(spacing: 15){
                
                TextField("1", text: $model.countryCode)
                    .keyboardType(.numberPad)
                    .padding(.vertical,12)
                    .padding(.horizontal)
                    .frame(width: 50)
                    .background(
                    
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(model.countryCode == "" ? Color.gray : Color("pink"),lineWidth: 1.5)
                    )
                
                TextField("123456789", text: $model.phNumber)
                    .keyboardType(.numberPad)
                    .padding(.vertical,12)
                    .padding(.horizontal)
                    .background(
                    
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(model.phNumber == "" ? Color.gray : Color("pink"),lineWidth: 1.5)
                    )
            }
            .padding(.top,20)
            
            Button(action: model.verifyUser, label: {
                Text("Login")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical,12)
                    .frame(maxWidth: .infinity)
                    .background(Color("pink"))
                    .cornerRadius(8)
            })
            .disabled(model.countryCode == "" || model.phNumber == "")
            .opacity(model.countryCode == "" || model.phNumber == "" ? 0.6 : 1)
            .padding(.top,20)
            
            Spacer()
        }
        .padding()
    }
}

struct OtpLogin_Previews: PreviewProvider {
    static var previews: some View {
        OtpLogin()
    }
}

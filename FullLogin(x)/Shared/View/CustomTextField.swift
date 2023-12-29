//
//  CustomTextField.swift
//  CustomTextField
//
//  Created by Balaji on 01/09/21.
//

import SwiftUI

struct CustomTextField: View {
    
    @State var isTapped = false
    // Hint...
    var hint: String
    @Binding var text: String
    
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4, content: {
            
            HStack(spacing: 15){
                
                // were going to limit the textfiled length....
                
                TextField("", text: $text) { (status) in
                    // it will fire when textfield is clicked...
                    if status{
                        withAnimation(.easeInOut.speed(1.5)){
                            // moving hint to top..
                            isTapped = true
                        }
                    }
                } onCommit: {
                    // it will fire when return button is pressed...
                    // only if no text typed..
                    if text == ""{
                        withAnimation(.easeInOut.speed(1.5)){
                            isTapped = false
                        }
                    }
                }
                
                // Trailing Icon Or Button...
                
                // Instaead of Button showing green Checkmark...
                if text != ""{
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.green)
                }
            }
            // Bold Font...
            .font(.system(size: 18, weight: .bold))
            .background(
            
                Text(hint)
                    .padding(.horizontal,isTapped ? 8 : 0)
                    .background(Color.white)
                    .scaleEffect(isTapped ? 0.7 : 1,anchor: .leading)
                    .offset(y: isTapped ? -26 : 0)
                    .foregroundColor(.gray)
                    
                
                ,alignment: .leading
            )
            .padding(.horizontal)
        })
        .frame(height: 55)
        .background(
        
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(.black,lineWidth: 1.8)
        )
    }
}

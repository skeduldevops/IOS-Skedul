//
//  PassForm.swift
//  Skedul
//
//  Created by skedul on 30/10/24.
//

import SwiftUI

struct PassForm: View {
    var label: String
    @Binding var password: String
    @State private var isPasswordVisible: Bool = false
    var placeholder: String = "Enter Password"
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(label)
                .font(.custom("Poppins-Medium", size: 14))
                .padding(.top, 12)
            
            HStack{
                if isPasswordVisible{
                    TextField(placeholder, text: $password)
                        .frame(height: 20)
                        .foregroundColor(Color("MainColor2"))
                }else{
                    SecureField(placeholder, text: $password)
                        .frame(height: 20)
                        .foregroundColor(Color("MainColor2"))
                }
                
                Button(action: {
                    isPasswordVisible.toggle()
                }){
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(Color("MainColor2"))
                        .frame(width: 20, height: 20)
                }
            }
            .padding()
            .background(Color.white)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("MainColor2"), lineWidth: 1.5))
            .cornerRadius(15)
            .padding(.bottom, 7)
        }
    }
}

#Preview {
    PassForm(label: "Password", password: .constant(""))
}

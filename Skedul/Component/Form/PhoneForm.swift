//
//  PhoneForm.swift
//  Skedul
//
//  Created by skedul on 31/10/24.
//

import SwiftUI

struct PhoneForm: View {
    var label: String
    var placeholder: String
    @Binding var number: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(label)
                .font(.custom("Poppins-Medium", size: 14))
                .padding(.top, 12)
            
            
            TextField(placeholder, text: Binding(
            get: {
                self.number
            },
            set: { newValue in
                
                let filtered = newValue.filter { "0123456789".contains($0)}
                self.number = filtered
            }
            ))
                .keyboardType(.numberPad)
                .frame(height: 20)
                .foregroundColor(Color("MainColor2"))
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color("MainColor2"), lineWidth: 1.5)
                ).cornerRadius(15)
        }
        .padding(.bottom, 7)
        
    }
        
}

#Preview {
    PhoneForm(label: "Phone Number", placeholder: "Enter Phone Number ", number: .constant(""))
}

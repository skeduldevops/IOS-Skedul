//
//  FillForm.swift
//  Skedul
//
//  Created by skedul on 30/10/24.
//

import SwiftUI



struct FillForm: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(label)
                .font(.custom("Poppins-Medium", size: 14))
                .padding(.top, 12)
            
            TextField(placeholder, text: $text)
                .frame(height: 20)
                .foregroundColor(Color("MainColor2"))
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color("MainColor2"), lineWidth: 1.5)
                )
                .cornerRadius(15)
        }
        .padding(.bottom, 5)
    }
}


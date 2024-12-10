//
//  PrimaryButton.swift
//  Skedul
//
//  Created by skedul on 30/10/24.
//


import SwiftUI

struct PrimaryButton: View {
    
    var label: String
    var action: ()->Void
    
    var body: some View {
        
        Button(action: action) {
            Text(label)
                .font(.custom("Poppins-Medium", size: 14))
                .foregroundColor(Color("MainColor2"))
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color("MainColor1"))
                .cornerRadius(15)
        }
        .padding(.top, 35)
        .padding(.bottom, 20)
    }
}

#Preview {
    PrimaryButton(label: "Login", action: {})
}


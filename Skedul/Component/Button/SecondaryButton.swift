//
//  SecondaryButton.swift
//  Skedul
//
//  Created by skedul on 30/10/24.
//

import SwiftUI

struct SecondaryButton: View {
    var label: String
    var action: ()->Void
    
    var body: some View {
        
        Button(action: action)
         {
            Text(label)
                 .font(.custom("Poppins-Reguler", size: 12))
                 .foregroundColor(.white)
                 .frame(width: 350, height: 50)
                 .background(Color("MainColor2"))
                 .cornerRadius(15)
         }
         .padding(.top, 35)
         .padding(.bottom, 20)
    }
}

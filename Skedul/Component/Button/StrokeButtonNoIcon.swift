//
//  StrokeButtonNoIcon.swift
//  Skedul
//
//  Created by skedul on 08/11/24.
//

import SwiftUI

struct StrokeButtonNoIcon: View {
    var label: String
    var action: ()->Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(label)
                    .font(.custom("Poppins-Medium", size: 14))
                    .foregroundColor(Color("MainColor2"))
                    .padding(.leading, 5)
            }
            .frame(width: 350, height: 50)
            .background(Color.white)
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color("MainColor2"), lineWidth: 0.5))
            .cornerRadius(15)
        }
        .padding(5)
    }
}

#Preview {
    StrokeButtonNoIcon(label: "Google Sign-in", action: {})
}

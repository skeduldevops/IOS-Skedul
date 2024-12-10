//
//  StrokeButton.swift
//  Skedul
//
//  Created by skedul on 05/11/24.
//

import SwiftUI



struct StrokeButton: View {
    
    var label: String
    var action: ()->Void
    var icon: String

    var body: some View {
        Button(action: action) {
            HStack {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .padding(.leading, 1)

                Text(label)
                    .font(.custom("Poppins-Medium", size: 14))
                    .foregroundColor(Color("MainColor2"))
                    .padding(.leading, 5)
            }
            .frame(width: 350, height: 50)
            .background(Color.white)
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color("MainColor2"), lineWidth: 1.5))
            .cornerRadius(15)
        }
        .padding(5)
    }
}

#Preview {
    StrokeButton(label: "Google Sign-in", action: {}, icon: "google-calendar")
}

//
//  BackButton.swift
//  Skedul
//
//  Created by skedul on 30/10/24.
//


import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode
    var labelText: String
    var destination: AnyView? = nil 
    var body: some View {
        if let destination = destination {
            NavigationLink(destination: destination) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("MainColor2"))

                    Text(labelText)
                        .font(.custom("Poppins-Bold", size: 24))
                        .foregroundColor(Color("MainColor2"))
                        .padding(.horizontal, 10)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 0)
                .cornerRadius(0)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, 40)
            .padding(.bottom, 40)
        } else {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("MainColor2"))

                    Text(labelText)
                        .font(.custom("Poppins-Bold", size: 24))
                        .foregroundColor(Color("MainColor2"))
                        .padding(.horizontal, 10)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 0)
                .cornerRadius(0)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, 40)
            .padding(.bottom, 40)
        }
    }
}

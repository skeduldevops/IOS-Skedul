//
//  PopUpWithCloseIconTemplate.swift
//  Skedul
//
//  Created by skedul on 19/12/24.
//

import SwiftUI

struct PopUpWithCloseIconTemplate: View {
    
    @State private var isVisible: Bool = true
    
    var title: String
    var message: String
    var imageName: String

    var body: some View {
        if isVisible {
            ZStack {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isVisible = false
                    }

                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .shadow(color: Color("MainCustom3"), radius: 10, x: 5, y: 5)
                        .frame(width: 360, height: 600)
                        .overlay(
                            VStack {
                                Spacer()

                                Image(imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 320, height: 320)

                                Text(title)
                                    .font(.custom("Poppins-Bold", size: 24))
                                    .padding(.horizontal, 45)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color("MainColor2"))
                                

                                Text(message)
                                    .font(.custom("Poppins-Reguler", size: 16))
                                    .foregroundColor(Color("MainColor3"))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 35)
                                    .padding(.top, 2)

                                Spacer()
                            }
                        )

                    Button(action: {
                        isVisible = false
                    }) {
                        Circle()
                            .fill(Color.white)
                            .shadow(color: Color("MainCustom3"), radius: 10, x: 5, y: 5)
                            .frame(width: 50, height: 50)
                            .overlay(
                                Image(systemName: "xmark")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color("MainColor2"))
                            )
                    }
                    .offset(x: 160, y: -350)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .animation(.easeInOut, value: isVisible)
        }
    }
}

#Preview {
    PopUpWithCloseIconTemplate(
            title: "Your Partner Account is Under Review",
            message: "Our Partner Team will verifying your business on 3 business days",
            imageName: "PopupSuccess"
    )
}

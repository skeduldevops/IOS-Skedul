//
//  PopUpWithButtonTemplate.swift
//  Skedul
//
//  Created by skedul on 19/12/24.
//

import SwiftUI

struct PopUpWithButtonTemplate: View {
    
    @State private var isVisible: Bool = true
    
    var title: String
    var message: String
    var imageName: String
    var labelButton: String
    var actionButton: ()->Void

    var body: some View {
        if isVisible {
            ZStack {
                Color("MainColor3").opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isVisible = false
                    }

                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .shadow(color: Color("MainCustom3"), radius: 10, x: 5, y: 5)
                        .frame(width: 360, height: 550)
                        .overlay(
                            VStack {
                                Spacer()
                                
                                Image(imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 320, height: 320)

                                Text(title)
                                    .font(.custom("Poppins-Bold", size: 24))
                                    .foregroundColor(Color("MainColor2"))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 45)

                                Text(message)
                                    .font(.custom("Poppins-Reguler", size: 16))
                                    .foregroundColor(Color("MainColor3"))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 35)
                                    .padding(.top, 2)

                                Button(action: actionButton) {
                                    Text(labelButton)
                                        .font(.custom("Poppins-Medium", size: 14))
                                        .foregroundColor(Color("MainColor2"))
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 55)
                                        .background(Color("MainColor1"))
                                        .cornerRadius(15)
                                }
                                .padding(.top, 20)
                                .padding(.bottom, 20)
                                .padding(.horizontal, 25)
                                
                                Spacer()
                            }
                        )
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .animation(.easeInOut, value: isVisible)
        }
    }
}


#Preview {
    PopUpWithButtonTemplate(
        title: "Password",
        message: "Confirm Your Password",
        imageName: "PopupEmailImage",
        labelButton: "Confirm",
        actionButton: {}
    )
}

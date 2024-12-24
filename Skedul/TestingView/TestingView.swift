//
//  TestingView.swift
//  Skedul
//
//  Created by skedul on 12/11/24.
//

import SwiftUI

struct TestingView: View {
    @State private var showCard: Bool = false
    var body: some View {
        ZStack {
            Color("MainColor2").opacity(0.2)
                .ignoresSafeArea()
                .onTapGesture {
                    showCard = false
                }

            VStack {
                Button(action: {
                    showCard = true
                }) {
                    Text("Show Card")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }

            if showCard {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .shadow(color: Color("MainCustom3"), radius: 10, x: 5, y: 5)
                        .frame(width: 360, height: 600)
                        .overlay(
                            VStack {
                                Spacer()

                                Image("PopupEmailImage")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 320, height: 320)
                                
                                Text("Reset Password")
                                    .font(.custom("Poppins-Bold", size: 24))
                                    .foregroundColor(Color("MainColor2"))
                                
                                Text("An email has been sent to endieblock3@gmail.com. Check the inbox and click the reset link provided")
                                    .font(.custom("Poppins-Reguler", size: 16))
                                    .foregroundColor(Color("MainColor3"))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 35)
                                    .padding(.top, 2)

                                Spacer()
                            }
                        )
                        .transition(.scale)
                        .zIndex(1)

                    Button(action: {
                        showCard = false
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
                    .zIndex(2)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .animation(.easeInOut, value: showCard)
    }
}

#Preview {
    TestingView()
}

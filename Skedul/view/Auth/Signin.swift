//
//  Signin.swift
//  Skedul
//
//  Created by skedul on 29/10/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct Signin: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var isPasswordVisible: Bool = false
    @State private var password = ""
    @State private var loginError = ""
    @State private var isLoggedIn = false
    @StateObject private var notificationDelegate = NotificationDelegate()

    var body: some View {
        VStack {
            Image("GreyIcon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 230, height: 230)
                .foregroundStyle(.tint)
                .padding(.top, 20)

            VStack(alignment: .leading) {
                Text("Email")
                    .font(.custom("Poppins-Medium", size: 14))
                    .padding(.top, 12)

                TextField("Enter Email", text: $email)
                    .frame(height: 20)
                    .foregroundColor(Color("MainColor2"))
                    .padding()
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color("MainColor2"), lineWidth: 1.5)
                    )
                    .cornerRadius(15)

                Text("Password")
                    .font(.custom("Poppins-Medium", size: 14))
                    .padding(.top, 12)

                HStack {
                    if isPasswordVisible {
                        TextField("Enter Password", text: $password)
                            .frame(height: 20)
                            .foregroundColor(Color("MainColor2"))
                    } else {
                        SecureField("Enter Password", text: $password)
                            .frame(height: 20)
                            .foregroundColor(Color("MainColor2"))
                    }

                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(Color("MainColor2"))
                            .frame(width: 20, height: 20)
                    }
                }
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color("MainColor2"), lineWidth: 1.5)
                )
                .cornerRadius(15)
                .padding(.bottom)
            }
            .padding(.horizontal, 20)
            
            PrimaryButton(label: "Login", action: login)
                .padding(15)

            if !loginError.isEmpty {
                Text(loginError)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            NavigationLink(destination: ForgotPassword()){
                Text("Forgot Password?")
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundColor(Color("MainColor2"))
            }
            

            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(labelText: ""))
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted {
                    UNUserNotificationCenter.current().delegate = notificationDelegate
                } else {
                    print("Notification permission denied.")
                }
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                loginError = error.localizedDescription
            } else {
                loginError = ""
                isLoggedIn = true
                createNotification(for: .loginWithEmail)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }}

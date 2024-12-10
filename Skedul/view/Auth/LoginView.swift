//
//  LoginView.swift
//  Skedul
//
//  Created by skedul on 29/10/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import UserNotifications

struct LoginView: View {
    @State private var loginError = ""
    @State private var isLoggedIn = false
    @State private var vm = AuthenticationView()
    @StateObject private var notificationDelegate = NotificationDelegate()
    
    var body: some View {
        NavigationView {
            VStack {
                Image("GreyIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 230, height: 230)
                    .foregroundStyle(.tint)

                NavigationLink(destination: Signin()) {
                    Text("Login")
                        .font(.custom("Poppins-Medium", size: 14))
                        .foregroundColor(Color("MainColor2"))
                        .frame(width: 350, height: 50)
                        .background(Color("MainColor1"))
                        .cornerRadius(15)
                }
                .padding(5)

                Button(action: {
                    vm.signInWithGoogle { success in
                        if success {
                            createNotification(for: .loginWithGoogle)
                            isLoggedIn = true
                        } else {
                            loginError = "Google Sign-In failed. Please try again."
                        }
                    }
                }) {
                    HStack {
                        Image("GoogleIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .padding(.leading, 1)

                        Text("Continue with Google")
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
                
                if !loginError.isEmpty {
                    Text(loginError)
                        .foregroundColor(.red)
                        .padding()
                }

                NavigationLink(destination: ContentView(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                
                NavigationLink(destination: Signup()) {
                    Text("Don't have an account yet? Sign Up")
                        .font(.custom("Poppins-Medium", size: 14))
                        .foregroundColor(Color("MainColor2"))
                }.padding(10)
            }
            .padding()
            .onAppear {
                UNUserNotificationCenter.current().delegate = notificationDelegate
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if !granted {
                        print("Notification permission denied.")
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

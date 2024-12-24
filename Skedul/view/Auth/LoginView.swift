//
//  LoginView.swift
//  Skedul
//
//  Created by skedul on 29/10/24.
//

import AuthenticationServices
import CryptoKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import SwiftUI
import UserNotifications

struct LoginView: View {
  @State private var loginError = ""
  @State private var isLoggedIn = false
  @State private var vm = AuthenticationView()
  @StateObject private var notificationDelegate = NotificationDelegate()

  @State var currentNonce: String?

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

          SignInWithAppleButton(
              onRequest: { request in
                  let nonce = vm.randomNonceString()
                  currentNonce = nonce
                  request.requestedScopes = [.fullName, .email]
                  request.nonce = vm.sha256(nonce)
              },
              onCompletion: { result in
                  vm.handleAppleSignIn(result: result, currentNonce: currentNonce) { success in
                      if success {
                          isLoggedIn = true
                      } else {
                          loginError = "Apple Sign-In failed. Please try again."
                      }
                  }
              }
          )
          .frame(width: 350, height: 50)
          .background(Color.white)
          .cornerRadius(15)
          .padding(5)


        StrokeButton(
          label: "Continue with Google",
          action: {
            vm.signInWithGoogle { success in
              if success {
                createNotification(for: .loginWithGoogle)
                isLoggedIn = true
              } else {
                loginError = "Google Sign-In failed. Please try again."
              }
            }
          }, icon: "GoogleIcon")

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
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
          granted, error in
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

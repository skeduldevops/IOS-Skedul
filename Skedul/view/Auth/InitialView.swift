//
//  InitialView.swift
//  Skedul
//
//  Created by skedul on 29/10/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct InitialView: View {
    @State private var userLoggedIn = (Auth.auth().currentUser != nil)
    @StateObject private var userManager = UserManager.shared  // Menggunakan UserManager.shared
    @State private var authStateListenerHandle: AuthStateDidChangeListenerHandle? // Properti untuk menyimpan listener

    var body: some View {
        VStack {
            if userLoggedIn {
                MainView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            userManager.fetchUserUID()
            
            // Menyimpan listener
            authStateListenerHandle = Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil {
                    userManager.isLoginSuccessful = true
                    userLoggedIn = true
                } else {
                    userManager.isLoginSuccessful = false
                    userLoggedIn = false
                }
            }
        }
        .onDisappear {
            // Melepaskan listener ketika view dihapus
            if let handle = authStateListenerHandle {
                Auth.auth().removeStateDidChangeListener(handle)
            }
        }
    }
}

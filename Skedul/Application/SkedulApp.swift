//
//  SkedulApp.swift
//  Skedul
//
//  Created by skedul on 29/10/24.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore

@main
struct SkedulApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
           InitialView()
                .environmentObject(UserManager.shared)
            
        }
    }
}


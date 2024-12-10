//
//  Application.swift
//  Skedul
//
//  Created by skedul on 29/10/24.
//

import SwiftUI
import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import UserNotifications


final class Application_utility{
    static var rootViewController: UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
            
        }
        return root
    }
}

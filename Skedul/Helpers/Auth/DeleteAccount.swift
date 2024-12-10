//
//  DeleteAccount.swift
//  Skedul
//
//  Created by skedul on 08/11/24.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn

class DeleteAccount: ObservableObject {
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }
        try await user.delete()
        GIDSignIn.sharedInstance.signOut()
        print("Account deleted successfully.")
    }
}

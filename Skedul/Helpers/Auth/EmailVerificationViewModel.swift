////
////  EmailVerificationViewModel.swift
////  Skedul
////
////  Created by skedul on 19/12/24.
////

import Foundation
import FirebaseAuth

class EmailVerificationViewModel: ObservableObject {
    @Published var isEmailVerified: Bool = false
    
    func checkEmailVerification() {
        guard let user = Auth.auth().currentUser else {
            isEmailVerified = false
            return
        }

        user.reload { [weak self] error in
            if let error = error {
                print("Error reloading user: \(error.localizedDescription)")
                self?.isEmailVerified = false
                return
            }

            self?.isEmailVerified = user.isEmailVerified
        }
    }
}

//
//  UserManager.swift
//  Skedul
//
//  Created by skedul on 05/11/24.
//
import SwiftUI
import FirebaseAuth
import FirebaseCore
import Firebase
import FirebaseFirestore
import FirebaseStorage

class UserManager: ObservableObject {
    static let shared = UserManager()

    @Published var currentUser: CurrentUser?
    @Published var isLoginSuccessful: Bool = false
    @Published var errorMessage: String = ""

    private init() {
        fetchUserUID()
    }

    func fetchUserUID() {
        if let user = Auth.auth().currentUser {
            isLoginSuccessful = true
            fetchUserData(uid: user.uid)
        } else {
            isLoginSuccessful = false
            currentUser = nil
        }
    }

    func fetchUserData(uid: String) {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(uid)

        docRef.getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            
            if let error = error {
               DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.isLoginSuccessful = false
                }
              return
            }

            guard let document = document, document.exists, let data = document.data() else {
                DispatchQueue.main.async {
                   self.errorMessage = "User data not found"
                   self.isLoginSuccessful = false
                }
              return
            }


            var user = CurrentUser(uid: uid)
            user.fullname = data["fullname"] as? String ?? "Unknown"
            user.username = data["username"] as? String ?? "Unknown"
            user.email = data["email"] as? String ?? "Unknown"
            user.phone = data["phone"] as? String ?? String(data["phone"] as? Int ?? 0)
            user.date_of_birth = data["date_of_birth"] as? String ?? "Unknown"
            user.created_at = data["created_at"] as? String ?? "Unknown"
            user.confirm_18 = data["confirm_18"] as? Bool ?? true
            user.agreed_term_policy = data["agreed_term_policy"] as? Bool ?? true
            user.profileImageUrl = data["profileImageUrl"] as? String ?? "Unknown"

            if let createdAtTimestamp = data["created_at"] as? Timestamp {
                let date = createdAtTimestamp.dateValue()
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .medium
                user.createdAt = formatter.string(from: date)
            } else {
                user.createdAt = "Unknown Date"
            }


            if let timestamp = data["date_of_birth"] as? Timestamp {
                let date = timestamp.dateValue()
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                dateFormatter.timeStyle = .none
                user.date_of_birth = dateFormatter.string(from: date)
            }

            DispatchQueue.main.async {
                self.currentUser = user
                self.isLoginSuccessful = true
                self.errorMessage = ""
            }
        }
    }
}

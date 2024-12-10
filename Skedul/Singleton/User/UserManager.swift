//
//  UserManager.swift
//  Skedul
//
//  Created by skedul on 05/11/24.
//

import SwiftUI
import FirebaseAuth
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
                self.errorMessage = error.localizedDescription
                self.isLoginSuccessful = false
                return
            }

            guard let document = document, document.exists, let data = document.data() else {
                self.errorMessage = "User data not found"
                self.isLoginSuccessful = false
                return
            }

            var user = CurrentUser(uid: uid)
            user.fullname = data["fullname"] as? String
            user.username = data["username"] as? String
            user.email = data["email"] as? String
            user.phone = data["phone"] as? String ?? String(data["phone"] as? Int ?? 0)
            user.date_of_birth = data["date_of_birth"] as? String
            user.created_at = data["created_at"] as? String
            user.confirm_18 = data["confirm_18"] as? Bool
            user.agreed_term_policy = data["agreed_term_policy"] as? Bool
            user.profileImageUrl = data["profileImageUrl"] as? String

            if let createdAtTimestamp = data["created_at"] as? Timestamp {
                let date = createdAtTimestamp.dateValue()
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .medium
                user.createdAt = formatter.string(from: date)
            }

            if let timestamp = data["date_of_birth"] as? Timestamp {
                let date = timestamp.dateValue()
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                dateFormatter.timeStyle = .none
                user.date_of_birth = dateFormatter.string(from: date)
            }

            if let profileImageUrl = user.profileImageUrl, !profileImageUrl.isEmpty {
                self.fetchProfileImage(from: profileImageUrl) { image in
                    user.profileImage = image
                    DispatchQueue.main.async {
                        self.currentUser = user
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.currentUser = user
                }
            }
        }
    }

    private func fetchProfileImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        let storageRef = Storage.storage().reference(forURL: url)
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
            } else if let imageData = data, let image = UIImage(data: imageData) {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}

//
//  CreateUsers.swift
//  Skedul
//
//  Created by skedul on 31/10/24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct CreateUsers {
    
    static func createUser(fullname: String, username: String, email: String, password: String, phone: String, dateOfBirth: Date, selectedImage: UIImage?, completion: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error.localizedDescription)
                return
            }
            guard let user = result?.user else {
                completion("User creation failed.")
                return
            }
            
            uploadProfileImage(userId: user.uid, selectedImage: selectedImage) { uploadError in
                if let uploadError = uploadError {
                    completion(uploadError)
                    return
                }
                
                let userData: [String: Any] = [
                    "fullname": fullname,
                    "email": email,
                    "username": username,
                    "id": user.uid,
                    "created_at": Timestamp(date: Date()),
                    "phone": phone,
                    "date_of_birth": dateOfBirth,
                    "confirm_18": true,
                    "agreed_term_policy": true
                ]
                
                Firestore.firestore().collection("users").document(user.uid).setData(userData) { error in
                    if let error = error {
                        completion("Failed to save user data: \(error.localizedDescription)")
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    }
    
    static func uploadProfileImage(userId: String, selectedImage: UIImage?, completion: @escaping (String?) -> Void) {
        guard let imageData = selectedImage?.jpegData(compressionQuality: 0.8) else {
            completion(nil)
            return
        }
        
        let storageRef = Storage.storage().reference().child("profile_images/\(userId).jpg")
        
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion("Error uploading image: \(error.localizedDescription)")
                return
            }
            completion(nil)
        }
    }
}

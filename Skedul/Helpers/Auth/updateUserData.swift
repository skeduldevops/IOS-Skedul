//
//  UserDataUpdater.swift
//  Skedul
//
//  Created by skedul on 18/11/24.
//

import Firebase
import FirebaseFirestore
import FirebaseAuth

struct UserDataUpdater {
    static func updateUserData(field: String, updatedValue: String, userManager: UserManager, completion: @escaping (Bool) -> Void) {
        guard let uid = userManager.currentUser?.uid else {
            completion(false)
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)
        
        userRef.updateData([field: updatedValue]) { error in
            if let error = error {
                print("Error updating document: \(error)")
                completion(false)
            } else {
                userManager.fetchUserData(uid: uid)
                completion(true)
            }
        }
    }
}

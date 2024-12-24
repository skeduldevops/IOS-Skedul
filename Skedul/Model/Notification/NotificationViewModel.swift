// NotificationViewModel.swift
// Skedul
// Created by skedul on 11/12/24.

import Foundation
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

class NotificationViewModel: ObservableObject {
    @Published var notifications: [NotificationModel] = []

    func fetchNotifications() {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()

        db.collection("Notification")
            .whereField("Id", isEqualTo: userUID)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error fetching notifications: \(error.localizedDescription)")
                    return
                }

                guard let documents = snapshot?.documents else { return }
                self.notifications = documents.map { doc in
                    let data = doc.data()
                    return NotificationModel(
                        id: doc.documentID,
                        title: data["Title"] as? String ?? "",
                        body: data["Body"] as? String ?? "",
                        status: data["Status"] as? String ?? "0"
                    )
                }
            }
    }

    func markAsRead(notificationID: String) {
        let db = Firestore.firestore()
        db.collection("Notification").document(notificationID).updateData(["Status": "1"]) { error in
            if let error = error {
                print("Error updating notification: \(error.localizedDescription)")
            } else {
                if let index = self.notifications.firstIndex(where: { $0.id == notificationID }) {
                    self.notifications[index].status = "1"
                }
            }
        }
    }
}

struct NotificationModel: Identifiable {
    let id: String
    let title: String
    let body: String
    var status: String
}

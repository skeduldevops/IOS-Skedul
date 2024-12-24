import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct NotifList: View {
    @State private var notifications: [Notification] = []
    @State private var isLoading = true
    let userUID: String

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading notifications...")
                    .padding()
            } else if notifications.isEmpty {
                Text("No notifications available.")
                    .foregroundColor(.gray)
            } else {
                List(notifications) { notification in
                    VStack {
                        NotifListItem(notification: notification)
                            .padding(.vertical, 5)
                            .onTapGesture {
                                print("Tapped on notification: \(notification.title)")
                                markAsRead(notification: notification)
                            }
                            .background(notification.isRead ? Color.gray.opacity(0.1) : Color.white)
                            .cornerRadius(8)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .onAppear {
            fetchNotifications()
        }
    }

    func fetchNotifications() {
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            print("User is not logged in.")
            return
        }

        let db = Firestore.firestore()
        db.collection("Notification")
            .whereField("userId", isEqualTo: currentUserUID)
            .limit(to: 100)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching notifications: \(error.localizedDescription)")
                    return
                }

                if let snapshot = snapshot {
                    var notifications: [Notification] = []
                    for document in snapshot.documents {
                        let data = document.data()
                        if let title = data["Title"] as? String,
                           let body = data["Body"] as? String,
                           let status = data["Status"] as? String,
                           let userId = data["userId"] as? String {
                            let notification = Notification(
                                id: document.documentID,
                                body: body,
                                title: title,
                                status: status,
                                userId: userId,
                                isRead: status == "read"
                            )
                            notifications.append(notification)
                        }
                    }
                    self.notifications = notifications
                    self.isLoading = false
                }
            }
    }

    func markAsRead(notification: Notification) {
        let db = Firestore.firestore()
        db.collection("Notification")
            .document(notification.id)
            .updateData(["Status": "read"]) { error in
                if let error = error {
                    print("Error marking notification as read: \(error.localizedDescription)")
                } else {
                    if let index = notifications.firstIndex(where: { $0.id == notification.id }) {
                        notifications[index].isRead = true
                    }
                    print("Notification marked as read")
                }
            }
    }
}

struct Notification: Identifiable {
    var id: String
    var body: String
    var title: String
    var status: String
    var userId: String
    var isRead: Bool
}

struct NotifListItem: View {
    let notification: Notification

    var body: some View {
        HStack {
            Image("Icon-NotifList")
                .resizable()
                .scaledToFit()
                .frame(width: 17, height: 17)
                .padding(.trailing, 8)

            VStack(alignment: .leading) {
                Text(notification.title)
                    .font(Font.custom("Poppins-Bold", size: 14))
                    .foregroundColor(notification.isRead ? Color.gray : Color("MainColor2"))
                    .padding(.bottom, 2)

                Text(notification.body)
                    .font(Font.custom("Poppins-Reguler", size: 12))
                    .foregroundColor(Color("MainColor3"))
                    .lineLimit(2)
            }

            Spacer()

            if notification.isRead {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
        .padding(.horizontal)
    }
}

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct ContentView: View {
    @StateObject private var authView = AuthenticationView()
    @State private var err: String = ""
    @State private var uid: String?
    @State private var email: String?
    @State private var fullname: String?
    @State private var username: String?
    @State private var createdAt: String?
    @State private var profileImageUrl: String?
    @State private var profileImage: UIImage?

    var body: some View {
        VStack {
            if authView.isLoginSuccessed {
                VStack {
                    Text("Hello, user!")
                        .font(.custom("Poppins-Bold", size: 20))
                        .padding()
                    
                    if let profileImage = profileImage {
                        Image(uiImage: profileImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .padding()
                    } else {
                        ProgressView()
                            .padding()
                    }

                    if let email = email, let uid = uid {
                        Text("Email: \(email)")
                        Text("UID: \(uid)")
                    }
                    
                    if let fullname = fullname, let username = username, let createdAt = createdAt {
                        Text("Full Name: \(fullname)")
                        Text("Username: \(username)")
                        Text("Created At: \(createdAt)")
                    } else {
                        Text("Loading user data...")
                    }

                    Button {
                        Task {
                            do {
                                try await authView.logout()
                                uid = nil
                                email = nil
                                fullname = nil
                                username = nil
                                createdAt = nil
                                profileImageUrl = nil
                                profileImage = nil
                            } catch let e {
                                err = e.localizedDescription
                            }
                        }
                    } label: {
                        Text("Log out")
                    }
                    
                    
                }
            } else {
                Signin()
            }
        }
        .onAppear {
            fetchUserUID()
        }
        .alert(isPresented: .constant(!err.isEmpty)) {
            Alert(title: Text("Error"), message: Text(err), dismissButton: .default(Text("OK")))
        }
    }
    
    func fetchUserUID() {
        if let user = Auth.auth().currentUser {
            uid = user.uid
            email = user.email
            authView.isLoginSuccessed = true
            fetchUserData(uid: user.uid)
        } else {
            uid = nil
            email = nil
            authView.isLoginSuccessed = false
        }
    }
    
    func fetchUserData(uid: String) {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(uid)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                fullname = data?["fullname"] as? String ?? "N/A"
                username = data?["username"] as? String ?? "N/A"
                profileImageUrl = data?["profileImageUrl"] as? String
                
                if let profileImageUrl = profileImageUrl, !profileImageUrl.isEmpty {
                    fetchProfileImage(from: profileImageUrl)
                } else {
                    profileImage = nil
                }
                
                if let createdAtTimestamp = data?["created_at"] as? Timestamp {
                    let date = createdAtTimestamp.dateValue()
                    let formatter = DateFormatter()
                    formatter.dateStyle = .medium
                    formatter.timeStyle = .medium
                    createdAt = formatter.string(from: date)
                } else {
                    createdAt = "N/A"
                }
            } else {
                err = error?.localizedDescription ?? "User data not found"
            }
        }
    }
    
    // Fungsi untuk mengambil gambar dari Firebase Storage
    func fetchProfileImage(from url: String) {
        let storage = Storage.storage()
        let storageRef = storage.reference(forURL: url)

        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            if let data = data, let image = UIImage(data: data) {
                profileImage = image
            }
        }
    }
}

#Preview {
    ContentView()
}

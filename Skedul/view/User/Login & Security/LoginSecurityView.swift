// LoginSecurityView.swift

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth

struct LoginSecurityView: View {
    
    @EnvironmentObject var userManager: UserManager
    @StateObject private var deleteAccount = DeleteAccount()
    @StateObject private var emailVerificationViewModel = EmailVerificationViewModel()
    @State private var showDeleteAlert = false
    @State private var showLogoutAlert = false
    @State private var showVerificationAlert = false
    @State private var message = ""
    @State private var showPopup = false
    
    var body: some View {
        
        ZStack {
            VStack {
                
                VStack(alignment: .leading, spacing: 16) {
                    VStack(spacing: 16) {
                        NavigationLink(destination: EditProfileView(field: "phone number", currentValue: userManager.currentUser?.phone ?? "")) {
                            ProfileInfoRow(label: formatFieldName("phone number"), value: userManager.currentUser?.phone ?? "Loading...")
                        }
                        Divider().background(Color("MainColor2").opacity(0.2))
                        
                        NavigationLink(destination: EditProfileView(field: "Email", currentValue: userManager.currentUser?.email ?? "")) {
                            ProfileInfoRow(label: formatFieldName("Email"), value: userManager.currentUser?.email ?? "Loading...")
                        }
                        
                        Divider().background(Color("MainColor2").opacity(0.2))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                
                VStack(spacing: 15) {
                    
                    StrokeButtonNoIcon(label: "Logout", action: { showLogoutAlert = true })
                        .alert(isPresented: $showLogoutAlert) {
                            Alert(
                                title: Text("Logout"),
                                message: Text("Are you sure you want to log out?"),
                                primaryButton: .destructive(Text("Logout")) {
                                    Task {
                                        do {
                                            try await AuthenticationView().logout()
                                        } catch {
                                            print("Logout failed: \(error.localizedDescription)")
                                        }
                                    }
                                },
                                secondaryButton: .cancel()
                            )
                        }
                        .padding(.bottom, 10)
                    
                    StrokeButton(label: "Send Verification Email", action: {
                        VerificationEmail()
                    }, icon: "envelope.badge")
                    
                    if showVerificationAlert {
                        Text("Verification email sent. Please check your inbox.")
                            .foregroundColor(.green)
                    }
                    
                    if !message.isEmpty {
                        Text(message)
                            .foregroundColor(.red)
                    }
                    
                    TextButton(label: "Delete Account", action: {
                        showDeleteAlert = true
                    })
                    .alert(isPresented: $showDeleteAlert) {
                        Alert(
                            title: Text("Delete Account"),
                            message: Text("Are you sure you want to delete your account? This action cannot be undone."),
                            primaryButton: .destructive(Text("Delete")) {
                                Task {
                                    do {
                                        try await deleteAccount.deleteAccount()
                                    } catch {
                                        print("Account deletion failed: \(error.localizedDescription)")
                                    }
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
                .padding()
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: BackButton(labelText: "Login & Security"))
                
            }
            
            if showPopup {
                PopupEmailVerification()
                    .transition(.opacity)
                    .zIndex(1)
                    .padding()
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    func VerificationEmail() {
        guard let user = Auth.auth().currentUser else {
            message = "No logged-in user found."
            return
        }
        
        if user.isEmailVerified {
            message = "Email is already verified."
            return
        }
        
        user.sendEmailVerification { error in
            if let error = error {
                message = "Error: \(error.localizedDescription)"
            } else {
                showPopup = true
            }
        }
    }
}

#Preview {
    LoginSecurityView()
}

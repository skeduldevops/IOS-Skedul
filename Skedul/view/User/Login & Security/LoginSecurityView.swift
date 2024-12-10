//
//  LoginSecurityView.swift
//  Skedul
//
//  Created by skedul on 07/11/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth


struct LoginSecurityView: View {
    
    @EnvironmentObject var userManager: UserManager
    @StateObject private var deleteAccount = DeleteAccount()
    @State private var showDeleteAlert = false
    @State private var showLogoutAlert = false
    
    var body: some View {
        
        
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
                
//                NavigationLink(destination: EditProfileView(field: "Change Password", currentValue: "")) {
//                    ProfileInfoRow(label: formatFieldName("Change Password"), value: userManager.currentUser?.password ?? "Loading...")
//                }
//                Divider().background(Color("MainColor2").opacity(0.2))
                
            }
        }.padding(.horizontal, 20)
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
                }.padding(.bottom, 10)
            
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
}


#Preview {
    LoginSecurityView()
}

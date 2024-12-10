//
//  EditProfileView.swift
//  Skedul
//
//  Created by skedul on 07/11/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth

struct EditProfileView: View {
    @EnvironmentObject var userManager: UserManager
    var field: String
    var currentValue: String
    @State private var updatedValue: String = ""
    @State private var showConfirmationAlert = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(alignment: .leading) {
            FillForm(label: formatFieldName(field), placeholder: currentValue, text: $updatedValue)
            
            Spacer()
            
            Divider()
                .background(Color("MainColor3"))
                .frame(height: 0.1)
            
            PrimaryButton(label: "Update") {
                if !updatedValue.isEmpty {
                    showConfirmationAlert = true
                }
            }
            .padding(.bottom, 20)
            .disabled(updatedValue.isEmpty || updatedValue == currentValue)
            .opacity((updatedValue.isEmpty || updatedValue == currentValue) ? 0.5 : 1.0)
            
        }
        .onAppear {
            updatedValue = currentValue
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(labelText: "My Profile"))
        .padding(.top)
        .padding()
        .edgesIgnoringSafeArea(.bottom)
        
        .alert(isPresented: $showConfirmationAlert) {
            Alert(
                title: Text("Confirm Update"),
                message: Text("Are you sure you want to update your \(field)?"),
                primaryButton: .destructive(Text("Update")) {
                    UserDataUpdater.updateUserData(field: field, updatedValue: updatedValue, userManager: userManager) { success in
                        if success {
                            dismiss()
                        }
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
}

#Preview {
    EditProfileView(field: "email", currentValue: "example@example.com")
        .environmentObject(UserManager.shared)
}

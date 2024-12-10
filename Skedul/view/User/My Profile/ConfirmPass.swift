//
//  ConfirmPass.swift
//  Skedul
//
//  Created by skedul on 18/11/24.
//

import SwiftUI
import FirebaseAuth

struct ConfirmPass: View {
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isEditEmailActive = false
    var onSuccess: (() -> Void)? // Tambahkan parameter onSuccess

    var body: some View {
        VStack {
            PassForm(label: "Password", password: $password, placeholder: "Enter Your Password")
            Spacer()

            Divider()
                .background(Color("MainColor3"))
                .frame(height: 0.1)

            NavigationLink(
                destination: EditProfileView(field: "email", currentValue: Auth.auth().currentUser?.email ?? ""),
                isActive: $isEditEmailActive
            ) {
                EmptyView()
            }

            PrimaryButton(label: "Next", action: {
                checkPassword()
            })
            .disabled(password.isEmpty)
            .opacity(password.isEmpty ? 0.5 : 1.0)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(labelText: "Confirm Password"))
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func checkPassword() {
        guard let user = Auth.auth().currentUser, let email = user.email else {
            alertTitle = "Error"
            alertMessage = "User not found."
            showAlert = true
            return
        }

        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        user.reauthenticate(with: credential) { result, error in
            if let error = error {
                alertTitle = "Password incorrect"
                alertMessage = "Your password is incorrect"
                showAlert = true
            } else {
                isEditEmailActive = true
                onSuccess?()
            }
        }
    }
}

#Preview {
    ConfirmPass()
}

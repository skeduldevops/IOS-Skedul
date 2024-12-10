//
//  ForgotPassword.swift
//  Skedul
//
//  Created by skedul on 15/11/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore

struct ForgotPassword: View {
    
    @State private var email = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var isEmailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    var body: some View {
        VStack {
            FillForm(label: "Email", placeholder: "Email", text: $email)
            
            Spacer()
            
            PrimaryButton(label: "Next", action: { resetPassword() })
                .disabled(!isEmailValid)
                .opacity(isEmailValid ? 1.0 : 0.5)
            
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(labelText: "Forgot Password"))
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Reset Password"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func resetPassword() {
        guard !email.isEmpty else {
            alertMessage = "Please enter your email address."
            showAlert = true
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                alertMessage = "Error: \(error.localizedDescription)"
            } else {
                alertMessage = "Password reset email has been sent to \(email)."
            }
            showAlert = true
        }
    }
}

#Preview {
    ForgotPassword()
}

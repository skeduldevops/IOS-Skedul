//
//  SignupPass.swift
//  Skedul
//
//  Created by skedul on 31/10/24.
//

import SwiftUI
import Firebase

struct SignupPass: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var password = ""
    @State private var confirmpassword = ""
    @State private var passwordErrorMessage = ""
    @State private var confirmPasswordErrorMessage = ""
    @State private var isAgeConfirmed = false
    @State private var isAgreedToPolicy = false
    @State private var ageErrorMessage = ""
    @State private var policyErrorMessage = ""
    @State private var uid: String? = nil
    @State private var errorMessage: String = ""
    @StateObject private var notificationDelegate = NotificationDelegate()
    
    var fullname: String
    var email: String
    var username: String
    var phone: String
    var dateOfBirth: Date
    var selectedImage: UIImage?

    var body: some View {
        VStack {
            PassForm(label: "Password", password: $password)
                .onChange(of: password) { _ in validatePassword() }
            if !passwordErrorMessage.isEmpty {
                ErrorMessageView(message: passwordErrorMessage)
            }
            
            PassForm(label: "Confirm Password", password: $confirmpassword)
                .onChange(of: confirmpassword) { _ in validateConfirmPassword() }
            if !confirmPasswordErrorMessage.isEmpty {
                ErrorMessageView(message: confirmPasswordErrorMessage)
            }
            
            ToggleWithAlert(isOn: $isAgeConfirmed,
                            toggleLabel: "I confirm that I am 18 years of age or older.",
                            alertMessage: "Please confirm your age.")
            
            ToggleWithAlert(isOn: $isAgreedToPolicy,
                            toggleLabel: "I agree with the 'privacy policy' & 'terms of use'.",
                            alertMessage: "You must agree to the policy to proceed.")
            
            if !ageErrorMessage.isEmpty {
                ErrorMessageView(message: ageErrorMessage)
            }
            if !policyErrorMessage.isEmpty {
                ErrorMessageView(message: policyErrorMessage)
            }
            
            if let uid = uid {
                Text("User UID: \(uid)")
                    .font(.headline)
                    .padding()
            }
            
            if !errorMessage.isEmpty {
                ErrorMessageView(message: errorMessage)
            }
            
            PrimaryButton(label: "Next", action: validateFields)
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted {
                    UNUserNotificationCenter.current().delegate = notificationDelegate
                } else {
                    print("Notification permission denied.")
                }
            }
        }
    }
    
    private func validatePassword() {
        passwordErrorMessage = ValidationSignupPass.validatePassword(password) ?? ""
    }
    
    private func validateConfirmPassword() {
        confirmPasswordErrorMessage = ValidationSignupPass.validateConfirmPassword(password: password, confirmPassword: confirmpassword) ?? ""
    }
    
    private func validateFields() {
        validatePassword()
        validateConfirmPassword()
        
        ageErrorMessage = ValidationSignupPass.validateAge(isAgeConfirmed: isAgeConfirmed) ?? ""
        policyErrorMessage = ValidationSignupPass.validatePolicy(isAgreedToPolicy: isAgreedToPolicy) ?? ""
        
        if passwordErrorMessage.isEmpty && confirmPasswordErrorMessage.isEmpty && isAgeConfirmed && isAgreedToPolicy {
            createUser()
        }
    }
    
    private func createUser() {
        CreateUsers.createUser(fullname: fullname, username: username, email: email, password: password, phone: phone, dateOfBirth: dateOfBirth, selectedImage: selectedImage) { errorMessage in
            if let errorMessage = errorMessage {
                self.errorMessage = errorMessage
                print("Error creating user: \(errorMessage)")
            } else {
                self.errorMessage = "User created and data saved!"
                print("User created successfully!")
                
                createNotification(for: .accountCreated)
            }
        }
    }
}

struct ErrorMessageView: View {
    var message: String
    var body: some View {
        Text(message)
            .foregroundColor(.red)
            .font(.caption)
    }
}

#Preview {
    SignupPass(fullname: "Full Name", email: "test@example.com", username: "username", phone: "1234567890", dateOfBirth: Date(), selectedImage: nil)
}

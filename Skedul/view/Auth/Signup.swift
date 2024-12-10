//
//  Signup.swift
//  Skedul
//
//  Created by skedul on 30/10/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct Signup: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var fullname = ""
    @State private var username = ""
    @State private var phone = ""
    @State private var dateOfBirth = Date()
    @State private var selectedImage: UIImage?
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                    ProfileImageForm(selectedImage: $selectedImage)
                    FillForm(label: "Full Name", placeholder: "Enter Full Name", text: $fullname)
                    FillForm(label: "Email Address", placeholder: "Enter Email", text: $email)
                    FillForm(label: "User Name", placeholder: "Enter Username", text: $username)
                    DateForm(label: "Date of Birth", placeholder: "Pick Date of Birth", date: $dateOfBirth)
                    PhoneForm(label: "Phone Number", placeholder: "Enter Phone Number", number: $phone)
                    
                    NavigationLink(destination: SignupPass(fullname: fullname, email: email, username: username, phone: phone, dateOfBirth: dateOfBirth, selectedImage: selectedImage)) {
                        PrimaryButton(label: "Next", action: validateFields)
                    }
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Validation Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(labelText: ""))
    }
    
    private func validateFields() {
        let validationResult = ValidationSignup.validateFields(fullname: fullname, email: email, username: username, phone: phone, dateOfBirth: dateOfBirth)
        
        if !validationResult.isValid {
            alertMessage = validationResult.alertMessage ?? ""
            showAlert = true
        }
    }
}

#Preview {
    Signup()
}

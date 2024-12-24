//
//  PopupEmailVerification.swift
//  Skedul
//
//  Created by skedul on 19/12/24.
//

import SwiftUI

struct PopupEmailVerification: View {
    @ObservedObject var authViewModel = AuthenticationView()
    
    var body: some View {
        VStack {
            PopUpWithButtonTemplate(
                title: "Verification Sent",
                message: "You need to log out to verify your account. Please log in again once the verification is complete.",
                imageName: "PopupEmailImage",
                labelButton: "Confirm",
                actionButton: {
                    Task {
                        do {
                            try await authViewModel.logout()
                            print("Logout Successful")
                        } catch {
                            print("Unable to log out at the moment: \(error.localizedDescription)")
                        }
                    }
                }
            )
        }
    }
}

#Preview {
    PopupEmailVerification()
}

//
//  ChatList.swift
//  Skedul
//
//  Created by skedul on 31/10/24.
//

import SwiftUI

struct ChatList: View {
    @State private var showLogoutAlert = false
    
    var body: some View {
            VStack {
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
                
                Spacer()

            }
            .padding()
            
    }
}
    
#Preview {
    ChatList()
}

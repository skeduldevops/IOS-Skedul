//
//  ToggleWithAlert.swift
//  Skedul
//
//  Created by skedul on 04/11/24.
//

import SwiftUI

struct ToggleWithAlert: View {
    @Binding var isOn: Bool
    @State private var showAlert = false
    var toggleLabel: String
    var alertMessage: String

    var body: some View {
        VStack {
            Toggle(isOn: $isOn) {
                Text(toggleLabel)
            }
            .toggleStyle(SwitchToggleStyle(tint: Color("MainColor2")))
            .font(.custom("Poppins-Regular", size: 12))
            .foregroundColor(Color("MainColor2"))
            .onChange(of: isOn) { value in
                if !value {
                    showAlert = true
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Notice"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

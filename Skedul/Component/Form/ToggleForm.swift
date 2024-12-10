//
//  ToggleForm.swift
//  Skedul
//
//  Created by skedul on 31/10/24.
//

import SwiftUI

struct ToggleForm: View {
    @State private var isOn = false
    var label: String
    
    var body: some View {
        HStack {
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: Color("MainColor2")))
            
            Spacer(minLength: 5)
            
            Text(label)
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(isOn ? Color("MainColor2") : .gray)
            
        }
        .padding(5)
    }
}

#Preview {
    ToggleForm(label: "Agree to Terms")
}

//
//  TextButton.swift
//  Skedul
//
//  Created by skedul on 08/11/24.
//

import SwiftUI

struct TextButton: View {
    
    var label: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.custom("Poppins-Bold", size: 14))
                .foregroundColor(Color("MainColor2"))
        }
    }
}

struct TextButton_Previews: PreviewProvider {
    static var previews: some View {
        TextButton(label: "Click Me", action: {
            print("Button clicked")
        })
    }
}

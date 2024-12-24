//
//  HelpView.swift
//  Skedul
//
//  Created by skedul on 07/11/24.
//

import SwiftUI

struct HelpView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        VStack {
            ButtonTab(
                activeButton: $selectedTab,
                buttonTitles: ["FAQ", "Contact Us"]
            )
            .padding()

            Group {
                if selectedTab == 0 {
                    
                    FaqList()
                    
                } else if selectedTab == 1 {
                    
                    ContactList()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(labelText: "Help"))
    }
}

#Preview {
    HelpView()
}

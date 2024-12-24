//
//  NotifList.swift
//  Skedul
//
//  Created by skedul on 11/12/24.
//

import SwiftUI

struct NotifList: View {
    var body: some View {
        VStack(spacing: 5) {
            NotifListCard(text: "Your payment has been successfully processed.")
            NotifListCard(text: "You have a new message from your service provider.")
            NotifListCard(text: "Don't forget to leave a review for your recent booking.")
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    NotifList()
}

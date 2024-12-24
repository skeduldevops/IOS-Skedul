// NotifListCard.swift
// Skedul
// Created by skedul on 11/12/24.

import SwiftUI

struct NotifListCard: View {
    var text: String
    var isRead: Bool

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(height: 50)
                .shadow(radius: 5)
                .overlay(
                    HStack {
                        Image("Icon-NotifList")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .padding(.leading, 10)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(text)
                                .font(.custom("Poppins-Light", size: 12))
                                .foregroundColor(Color(isRead ? "MainColor3" : "MainColor2"))
                                .lineLimit(2)
                                .truncationMode(.tail)
                                .frame(width: 200, alignment: .leading)
                        }
                        .padding(.leading, 10)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.gray)
                            .padding(.trailing, 8)
                    }
                    .padding()
                )
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NotifListCard(
        text: "This is a notification",
        isRead: false
    )
}

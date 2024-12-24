//
//  ButtonTab.swift
//  Skedul
//
//  Created by skedul on 12/12/24.
//
import SwiftUI

struct ButtonTab: View {
    @Binding var activeButton: Int
    let buttonTitles: [String]

    var body: some View {
        HStack(spacing: 20) {
            ForEach(buttonTitles.indices, id: \.self) { index in
                CustomButton(
                    title: buttonTitles[index],
                    isActive: activeButton == index
                ) {
                    activeButton = index
                }
            }
        }
    }
}

struct CustomButton: View {
    let title: String
    let isActive: Bool
    let action: () -> Void
    let activeColor: Color = Color("MainColor2")
    let inactiveColor: Color = Color("MainColor3")

    var body: some View {
        Button(action: action) {
            VStack {
                Text(title)
                    .font(.custom("Poppins-Regular", size: 16))
                    .foregroundColor(isActive ? activeColor : inactiveColor)

                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(isActive ? activeColor : .clear)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ExampleUsageView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        VStack {
            ButtonTab(
                activeButton: $selectedTab,
                buttonTitles: ["Home", "Profile", "Settings"]
            )

            Text("Selected Tab: \(selectedTab)")
                .padding()
        }
    }
}

#Preview {
    ExampleUsageView()
}

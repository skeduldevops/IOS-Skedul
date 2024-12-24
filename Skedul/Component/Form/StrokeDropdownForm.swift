//
//  StrokeDropdownButton.swift
//  Skedul
//
//  Created by skedul on 18/12/24.
//

import SwiftUI

struct StrokeDropdownForm: View {
    @State private var isExpanded: Bool = false
    @State private var selectedValue: String = "You come to us"

    var label: String = "Type of service"
    var dropdownItems: [String] = ["You come to us", "We come to you"]

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 10) {
                
                Text(label)
                    .font(.custom("Poppins-Bold", size: 16))
                    .foregroundColor(Color("MainColor2"))

                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    HStack {
                        Text(selectedValue)
                            .font(.custom("Poppins-Bold", size: 14))
                            .foregroundColor(Color("MainColor3"))
                        Spacer()
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(Color("MainColor3"))
                            .font(.system(size: 16, weight: .medium))
                    }
                    .padding()
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }

                if isExpanded {
                    VStack(spacing: 0) {
                        ForEach(dropdownItems.indices, id: \.self) { index in
                            Button(action: {
                                selectedValue = dropdownItems[index]
                                withAnimation {
                                    isExpanded.toggle()
                                }
                            }) {
                                Text(dropdownItems[index])
                                    .font(.custom("Poppins-Reguler", size: 14))
                                    .foregroundColor(Color("MainColor2"))
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.white)
                            }
                            if index < dropdownItems.count - 1 {
                                Divider()
                            }
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                            .background(Color.white)
                    )
                    .frame(width: geometry.size.width)
                    .offset(y: geometry.size.height + 4)
                }
            }
        }
        .frame(height: 0.1)
        .padding()
    }
}

#Preview {
    StrokeDropdownButton()
}

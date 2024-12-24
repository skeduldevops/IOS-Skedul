//
//  StrokeDropdownForm.swift
//  Skedul
//
//  Created by skedul on 18/12/24.
//

import SwiftUI

struct StrokeDropdownForm: View {
    @State private var isExpanded: Bool = false
    @State private var selectedValue: String
    
    var label: String
    var dropdownItems: [String]
    
    init(label: String, dropdownItems: [String], defaultValue: String? = nil) {
        self.label = label
        self.dropdownItems = dropdownItems
        _selectedValue = State(initialValue: defaultValue ?? dropdownItems.first ?? "")
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 10) {
                Text(label)
                    .font(.custom("Poppins-Medium", size: 16))
                    .foregroundColor(Color("MainColor2"))
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    HStack {
                        Text(selectedValue)
                            .font(.custom("Poppins-Bold", size: 14))
                            .foregroundColor(Color("MainColor2"))
                        Spacer()
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(Color("MainColor3"))
                            .font(.system(size: 16, weight: .medium))
                    }
                    .padding()
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray.opacity(0.7), lineWidth: 0.5)
                            .background(Color.white)
                            .shadow(color: Color("MainColor3").opacity(0.2), radius: 5, x: 0, y: 2)
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
                            .stroke(Color.gray.opacity(0.7), lineWidth: 0.5)
                            .background(Color.white)
                            .shadow(color: Color("MainColor3").opacity(0.2), radius: 15, x: 0, y: 2)
                    )
                    .padding(.top, 0)
                    .frame(width: geometry.size.width)
                }
            }
        }
    }
}

extension StrokeDropdownForm {
    static func previewExample() -> StrokeDropdownForm {
        return StrokeDropdownForm(
            label: "Type of service",
            dropdownItems: ["You come to us", "We come to you"],
            defaultValue: "You come to us"
        )
    }
}

#Preview {
    StrokeDropdownForm.previewExample()
}

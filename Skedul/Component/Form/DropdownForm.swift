import SwiftUI

struct DropdownForm: View {
    var label: String
    var options: [String]
    @Binding var selectedOption: String
    var onChange: (() -> Void)? = nil

    @State private var isDropdownOpen: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.custom("Poppins-Medium", size: 16))
                .padding(.top, 12)
                .foregroundColor(Color("MainColor2"))

            Button(action: {
                withAnimation {
                    isDropdownOpen.toggle()
                }
            }) {
                HStack {
                    Text(selectedOption.isEmpty ? "Select an option" : selectedOption)
                        .foregroundColor(selectedOption.isEmpty ? .gray : Color("MainColor2"))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Image(systemName: isDropdownOpen ? "chevron.up" : "chevron.down")
                        .foregroundColor(Color("MainColor2"))
                }
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color("MainColor2"), lineWidth: 1.5)
                )
                .cornerRadius(15)
            }

            if isDropdownOpen {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(options.indices, id: \.self) { index in
                        Button(action: {
                            selectedOption = options[index]
                            isDropdownOpen = false
                        }) {
                            Text(options[index])
                                .foregroundColor(Color("MainColor2"))
                                .padding()
                        }
                        
                        if index < options.count - 1 {
                            Divider()
                                .background(Color("MainColor3").opacity(0.4))
                        }
                    }
                }
                .padding(.bottom, 2)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray.opacity(0.7), lineWidth: 0.5)
                        .shadow(color: Color("MainColor3").opacity(0.2), radius: 15, x: 0, y: 2)
                )
            }
        }
        .onChange(of: selectedOption, perform: { _ in
                        onChange?()
                    })
    }
}

struct DropdownForm_Previews: PreviewProvider {
    struct Wrapper: View {
        @State private var selectedOption = ""

        var body: some View {
            DropdownForm(
                label: "Select Item",
                options: ["Option 1", "Option 2", "Option 3"],
                selectedOption: $selectedOption
            )
            .padding()
            .previewLayout(.sizeThatFits)
        }
    }

    static var previews: some View {
        Wrapper()
    }
}

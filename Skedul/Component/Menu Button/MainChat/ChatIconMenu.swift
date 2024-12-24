import SwiftUI

struct ChatIconMenu: View {
    @State private var activeIcon: Int = 1

    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 30) {
                MenuButton(iconName: activeIcon == 1 ? "icon-chatactive" : "icon-chatnon", label: "Chat") {
                    activeIcon = 1
                }
                MenuButton(iconName: activeIcon == 2 ? "icon-notifactive" : "icon-notifnon", label: "Notification") {
                    activeIcon = 2
                }
                MenuButton(iconName: activeIcon == 3 ? "icon-skedulactive" : "icon-skedulnon", label: "Support") {
                    activeIcon = 3
                }
            }
            .padding()

            if activeIcon == 1 {
                ChatList() // Ganti dengan tampilan yang sesuai
            } else if activeIcon == 2 {
                NotifList(userUID: "user-id-value")
            } else if activeIcon == 3 {
                LiveChat() // Ganti dengan tampilan yang sesuai
            }
        }
    }
}

struct MenuButton: View {
    let iconName: String
    let label: String
    let action: () -> Void

    var body: some View {
        VStack {
            Button(action: action) {
                Image(iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)
            }
            .buttonStyle(PlainButtonStyle())

            Text(label)
                .font(.headline)
                .foregroundColor(Color("MainColor2"))
                .font(.custom("Poppins-Light", size: 10))
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    ChatIconMenu()
}

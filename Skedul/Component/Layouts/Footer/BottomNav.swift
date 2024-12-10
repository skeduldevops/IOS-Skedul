import SwiftUI

struct BottomNav: View {
    @Binding var selectedTab: Int

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 35)
                .fill(Color.white)
                .frame(height: 80)
                .frame(maxWidth: .infinity)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -3)

            HStack(spacing: 30) {
                BottomNavButton(iconName: selectedTab == 0 ? "MenuIconActive" : "MenuIcon", isSelected: selectedTab == 0) { selectedTab = 0 }
                BottomNavButton(iconName: selectedTab == 1 ? "CouponsIconActive" : "CouponsIcon", isSelected: selectedTab == 1) { selectedTab = 1 }
                BottomNavButton(iconName: selectedTab == 2 ? "SkedulIconActive" : "SkedulIcon", isSelected: selectedTab == 2) { selectedTab = 2 }
                BottomNavButton(iconName: selectedTab == 3 ? "ChatIconActive" : "ChatIcon", isSelected: selectedTab == 3) { selectedTab = 3 }
                BottomNavButton(iconName: selectedTab == 4 ? "UserIconActive" : "UserIcon", isSelected: selectedTab == 4) { selectedTab = 4 }
            }
            .frame(height: 80)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct BottomNavButton: View {
    var iconName: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
                .foregroundColor(isSelected ? .blue : .gray)
                .padding(.bottom, 5)
        }
    }
}

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Int = 2
    @StateObject private var notificationDelegate = NotificationDelegate()

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch selectedTab {
                case 0:
                    MainService()
                case 1:
                    MainCopouns()
                case 2:
                    MainCalendar()
                case 3:
                    ConfirmPass()
                case 4:
                    MainUser()
                case 5:
                    MyBookingView()
                default:
                    Text("Menu View")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            if shouldShowBottomNav() {
                BottomNav(selectedTab: $selectedTab)
                    .frame(height: 80)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func shouldShowBottomNav() -> Bool {
        return selectedTab != 5
    }
}

#Preview {
    MainView()
}

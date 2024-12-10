//
//  MenuItemUser.swift
//  Skedul
//
//  Created by skedul on 05/11/24.
//

// MenuItemUser.swift
import Foundation

enum MenuOption: String, CaseIterable {
    case myBookings = "My Bookings"
    case myProfile = "My Profile"
    case loginSecurity = "Login & Security"
    case help = "Help"
    case about = "About"
    case registerPartner = "Register as Partner"

    var iconName: String {
        switch self {
        case .myBookings: return "MyBookingsIcon"
        case .myProfile: return "MyProfileIcon"
        case .loginSecurity: return "LoginSecurityIcon"
        case .help: return "HelpIcon"
        case .about: return "AboutIcon"
        case .registerPartner: return "RegisterPartnerIcon"
        }
    }
}

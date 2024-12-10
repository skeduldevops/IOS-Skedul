//
//  MenuListUser.swift
//  Skedul
//
//  Created by skedul on 05/11/24.
//


// MenuListUser.swift

import SwiftUI

struct MenuListUser: View {
    var body: some View {
        VStack(spacing: 5) {
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color("MainColor2").opacity(0.1))
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.3), radius: 6, x: 0, y: -4)
            
            HStack{
                Text("Personal Detail")
                    .font(.custom("Poppins-Bold",size: 22))
                    .foregroundColor(Color("MainColor2"))
                    .padding(.top, 13)
                    .padding(.bottom, 13)
                    .padding(.leading, 8)
                Spacer()
                
            }.padding(.horizontal)
            
            ForEach(MenuOption.allCases, id: \.self) { option in
                NavigationLink(destination: MenuViewFactory.view(for: option)) {
                    HStack {
                        
                        Image(option.iconName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                        
                        Text(option.rawValue)
                            .font(.custom("Poppins-Regular", size: 15))
                            .foregroundColor(Color("MainColor2"))
                            .padding(.leading, 5)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                            .padding(.leading, 15)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .padding(.leading, 5)
                }
                Divider()
                    .background(Color("MainColor2").opacity(0.1))
            }

            StrokeButton(label: "Connect With Google Calendar", action: {}, icon: "google-calendar")
                .padding(.top, 30)
                .padding(.bottom, 30)
        }
        .cornerRadius(12, corners: [.topLeft, .topRight])
        .padding(.horizontal, 0)
        .padding(.top, 8)
        .padding(.bottom, 16)
    }
}


struct MenuViewFactory {
    @ViewBuilder
    static func view(for option: MenuOption) -> some View {
        switch option {
        case .myBookings:
            MyBookingView()
        case .myProfile:
            MyProfileView()
        case .loginSecurity:
            LoginSecurityView()
        case .help:
            HelpView()
        case .about:
            AboutView()
        case .registerPartner:
            RegisterPartnerView()
        }
    }
}


#Preview{
    MenuListUser()
}

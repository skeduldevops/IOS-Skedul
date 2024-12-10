//
//  MyProfileView.swift
//  Skedul
//
//  Created by skedul on 07/11/24.
//

import SwiftUI

struct MyProfileView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var isPasswordConfirmed: Bool = false
    
    @State private var isEditProfileActive: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack {
                if let profileImage = userManager.currentUser?.profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .padding(.top, 75)
                        .padding(.bottom, 30)
                        .padding(.leading, 20)
                } else {
                    Image("default")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .padding(.top, 75)
                        .padding(.bottom, 30)
                        .padding(.leading, 20)
                }
                Spacer()
            }

            VStack(alignment: .leading, spacing: 16) {
                Text("Personal Detail")
                    .font(.custom("Poppins-SemiBold", size: 24))
                    .foregroundColor(Color("MainColor2"))
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                    .padding(.top, 20)

                VStack(spacing: 16) {
                    NavigationLink(destination: EditProfileView(field: "fullname", currentValue: userManager.currentUser?.fullname ?? "")) {
                        ProfileInfoRow(label: formatFieldName("fullname"), value: userManager.currentUser?.fullname ?? "Loading...")
                    }
                    Divider().background(Color("MainColor2").opacity(0.2))

                    NavigationLink(destination: EditProfileView(field: "date_of_birth", currentValue: userManager.currentUser?.date_of_birth ?? "")) {
                        ProfileInfoRow(label: formatFieldName("date_of_birth"), value: userManager.currentUser?.date_of_birth ?? "Loading...")
                    }
                    Divider().background(Color("MainColor2").opacity(0.2))

                    NavigationLink(destination: ConfirmPass(onSuccess: {
                        isPasswordConfirmed = true
                    }), isActive: $isPasswordConfirmed) {
                        ProfileInfoRow(label: formatFieldName("email"), value: userManager.currentUser?.email ?? "Loading...")
                    }
                    
                    Divider().background(Color("MainColor2").opacity(0.2))

                    NavigationLink(destination: EditProfileView(field: "phone number", currentValue: userManager.currentUser?.phone ?? "")) {
                        ProfileInfoRow(label: formatFieldName("phone number"), value: userManager.currentUser?.phone ?? "Loading...")
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 250)
            }
            .padding(.horizontal, 0)
            .padding(.top, 10)
            .background(Color.white)
            .cornerRadius(12, corners: [.topLeft, .topRight])
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            .padding(.horizontal, 0)

            Spacer()
        }
        .padding(.top, 15)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(labelText: "My Profile"))
        .background(Color("BackgroundColor").ignoresSafeArea())
    }
}

struct ProfileInfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color.gray)

            Spacer()

            Text(value)
                .font(.custom("Poppins-SemiBold", size: 16))
                .foregroundColor(Color("MainColor2"))

            Image(systemName: "chevron.right")
                .foregroundColor(Color.gray)
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = 0.0
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

func formatFieldName(_ field: String) -> String {
    return field
        .split(separator: "_")
        .map { $0.capitalized }
        .joined(separator: " ")
}

#Preview {
    MyProfileView()
        .environmentObject(UserManager.shared)
}

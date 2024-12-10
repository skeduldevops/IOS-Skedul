//
//  MainUser.swift
//  Skedul
//
//  Created by skedul on 31/11/24.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

/*
struct MainUser: View {
    
    @EnvironmentObject var userManager: UserManager
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 3) {
                    Image("poto_profil")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.bottom, 10)

                    Text("Andhika Devara Ganteng Banget")
                        .font(.custom("Poppins-Medium", size: 20))
                        .foregroundColor(.black)

                    Text("+62 852323121")
                        .font(.custom("Poppins-Regular", size: 13))
                        .foregroundColor(Color("MainColor2"))

                    Text("Endistress@gmail.com")
                        .font(.custom("Poppins-Regular", size: 13))
                        .foregroundColor(Color("MainColor2"))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 24)
                .padding(.trailing, 16)
                .padding(.top, 20)
                .padding(.bottom, 10)

                ScrollView {
                    MenuListUser()
                        .padding(.horizontal, 0)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    MainUser()
}
*/

//
//  MainUser.swift
//  Skedul
//
//  Created by skedul on 31/11/24.
//



struct MainUser: View {
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                if let user = userManager.currentUser {
                    VStack(alignment: .leading, spacing: 3) {
                        if let profileImage = user.profileImage {
                            Image(uiImage: profileImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        } else {
                            Image("default")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        }

                        Text(user.fullname ?? "Nama tidak tersedia")
                            .font(.custom("Poppins-Medium", size: 20))
                            .foregroundColor(.black)

                        Text(user.phone ?? "Nomor telepon tidak tersedia")
                            .font(.custom("Poppins-Regular", size: 13))
                            .foregroundColor(Color("MainColor2"))

                        Text(user.email ?? "Email tidak tersedia")
                            .font(.custom("Poppins-Regular", size: 13))
                            .foregroundColor(Color("MainColor2"))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 24)
                    .padding(.trailing, 16)
                    .padding(.top, 20)
                    .padding(.bottom, 10)

                    ScrollView {
                        MenuListUser()
                            .padding(.horizontal, 0)
                    }
                } else {
                    Text("Load Users Data...")
                        .font(.custom("Poppins-Medium", size: 20))
                        .foregroundColor(Color("MainColor2"))
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            userManager.fetchUserUID()
        }
    }
}

#Preview {
    MainUser()
        .environmentObject(UserManager.shared)
}

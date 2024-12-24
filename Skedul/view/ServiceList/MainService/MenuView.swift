////
////  MenuView.swift
////  Skedul
////
////  Created by skedul on 08/11/24.
////
//
//import SwiftUI
//
//struct MenuView: View {
//    let iconName: String
//    let menuName: String
//    let submenuItems: [SubmenuItem]
//    let isExpanded: Bool
//    let onToggle: () -> Void
//    let onSubmenuSelect: (String) -> Void
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            HStack {
//                Image(iconName)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 22, height: 22)
//
//                Text(menuName)
//                    .font(.custom("Poppins-SemiBold", size: 15))
//                    .foregroundColor(Color("MainColor2"))
//                Spacer()
//                Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
//                    .padding(.trailing, 8)
//                    .foregroundColor(Color("MainColor3"))
//            }
//            .padding()
//            .onTapGesture {
//                onToggle()
//            }
//            
//            if isExpanded {
//                VStack(alignment: .leading, spacing: 8) {
//                    ForEach(submenuItems) { submenu in
//                        HStack {
//                            Image(submenu.name)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 22, height: 22)
//
//                            Text(submenu.name)
//                                .font(.custom("Poppins-S emiBold", size: 16))
//                                .foregroundColor(Color("MainColor2"))
//                            Spacer()
//                            Image(systemName: "chevron.right")
//                                .foregroundColor(Color("MainColor3"))
//                                .padding(.trailing, 10)
//                        }
//                        .padding(.leading, 25)
//                        .onTapGesture {
//                            onSubmenuSelect(submenu.name)
//                        }
//                    }
//                    .padding(.top, 12)
//                    .padding(.bottom, 10)
//                }
//                .padding(.bottom, 10)
//                .background(Color.white)
//                .cornerRadius(10)
//                .padding(.horizontal)
//            }
//        }
//        .background(Color.white)
//        .cornerRadius(10)
//        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
//        .overlay(
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(Color("MainColor2"), lineWidth: 0.1)
//        )
//    }
//}
//
//struct SubmenuItem: Identifiable {
//    let id = UUID()
//    let iconName: String
//    let name: String
//}

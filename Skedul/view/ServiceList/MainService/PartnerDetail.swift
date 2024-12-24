////
////  PartnerDetail.swift
////  Skedul
////
////  Created by skedul on 17/12/24.
////
//
//import SwiftUI
//
//struct PartnerDetail: View {
//    var body: some View {
//        ZStack {
//            Image("partnerimage")
//                .resizable()
//                .scaledToFill()
//                .frame(maxWidth: .infinity, maxHeight: 300)
//                .clipped()
//            
//            HStack {
//                Button(action: {
//                    print("Back button tapped")
//                }) {
//                    Image(systemName: "chevron.left")
//                        .font(.system(size: 20, weight: .bold))
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.black.opacity(0.5))
//                        .clipShape(Circle())
//                }
//                Spacer()
//                HStack(spacing: 16) {
//                    Button(action: {
//                        print("Heart button tapped")
//                    }) {
//                        Image(systemName: "heart")
//                            .font(.system(size: 20, weight: .bold))
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.black.opacity(0.5))
//                            .clipShape(Circle())
//                    }
//                    
//                    Button(action: {
//                        print("Share button tapped")
//                    }) {
//                        Image(systemName: "square.and.arrow.up")
//                            .font(.system(size: 20, weight: .bold))
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.black.opacity(0.5))
//                            .clipShape(Circle())
//                    }
//                }
//            }
//            .padding([.leading, .trailing, .top], 26)
//            .padding(.bottom, 230)
//        }
//        .edgesIgnoringSafeArea(.top)
//    }
//}
//
//#Preview {
//    PartnerDetail()
//}

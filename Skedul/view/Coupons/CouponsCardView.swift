//
//  CouponsCardView.swift
//  Skedul
//
//  Created by skedul on 08/11/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth
import FirebaseStorage

struct Coupon: Identifiable, Codable {
    @DocumentID var id: String?
    var description: String
    var title: String
    var valid: Date
    var image: String
    var code: String
}

class CouponsViewModel: ObservableObject {
    @Published var coupons = [Coupon]()
    private var db = Firestore.firestore()
    init() {
        fetchCoupons()
    }
    
    func fetchCoupons() {
        db.collection("Coupons").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching coupons: \(error)")
                return
            }
            self.coupons = snapshot?.documents.compactMap { document in
                try? document.data(as: Coupon.self)
            } ?? []
        }
    }
}

struct CouponsCardView: View {
    @StateObject private var viewModel = CouponsViewModel()

    var body: some View {

            VStack(spacing: 8) {
                ForEach(viewModel.coupons) { coupon in
                    NavigationLink(destination: DetailCoupons(coupon: coupon)) { // Menambahkan NavigationLink
                        CouponCard(coupon: coupon)
                            .padding(.horizontal)
                    }
                    .buttonStyle(PlainButtonStyle()) // Agar tidak ada gaya default pada tombol
                }
            }
            .padding(.vertical)
        
    }
}

struct CouponCard: View {
    var coupon: Coupon
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(height: 150)
                .shadow(radius: 5)
                .overlay(
                    HStack {
                        Image(coupon.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.leading, 0)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(coupon.title)
                                .font(.custom("Poppins-Bold", size: 20))
                                .foregroundColor(Color("MainColor2"))
                            
                            Text(coupon.description.count > 60 ? "\(coupon.description.prefix(60))..." : coupon.description)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .lineLimit(2)
                                .frame(height: 50)
                            
                            Divider()
                                .background(Color("MainColor2"))
                                .frame(height: 0.1)
                            
                            Text("Valid Until \(formattedDate(coupon.valid))")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 8)
                    }
                    .padding()
                )
        }
        .padding(.vertical, 4)
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    CouponsCardView()
}

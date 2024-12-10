//
//  DetailCoupons.swift
//  Skedul
//
//  Created by skedul on 08/11/24.
//

import SwiftUI

struct DetailCoupons: View {
    var coupon: Coupon
    
    @State private var isCouponsExpanded = false
    @State private var isTermsExpanded = false
    @State private var showCopiedAlert = false
    
    var body: some View {
        
        ScrollView {
            VStack {
                Image("deals1")
                    .resizable()
                    .scaledToFill()
                    .frame(height: UIScreen.main.bounds.height * 0.3)
                    .clipped()
                    .padding(.top, 20)
                
                VStack(alignment: .leading) {
                    Text(coupon.title)
                        .font(.custom("Poppins-Bold", size: 22))
                        .foregroundColor(Color("MainColor2"))
                        .padding(.bottom, 2)
                    
                    Text("Valid until \(formattedDate(coupon.valid))")
                        .font(.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color("MainColor3"))
                    
                    Divider()
                        .frame(height: 0.2)
                        .background(Color("MainColor3").opacity(0.3))
                        .padding(.vertical, 10)
                    
                    HStack {
                        Text("Coupons Details")
                            .font(.custom("Poppins-Bold", size: 18))
                            .foregroundColor(Color("MainColor2"))
                        
                        Spacer()
                        
                        Image(systemName: isCouponsExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(Color("MainColor2"))
                    }
                    .onTapGesture {
                        withAnimation {
                            isCouponsExpanded.toggle()
                        }
                    }
                    
                    if isCouponsExpanded {
                        Text(coupon.description)
                            .font(.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color("MainColor3"))
                            .padding(.top, 4)
                    }
                    
                    Divider()
                        .frame(height: 0.2)
                        .background(Color("MainColor3").opacity(0.3))
                        .padding(.vertical, 10)
                    
                    HStack {
                        Text("Terms & Conditions")
                            .font(.custom("Poppins-Bold", size: 18))
                            .foregroundColor(Color("MainColor2"))
                        
                        Spacer()
                        
                        Image(systemName: isTermsExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(Color("MainColor2"))
                    }
                    .onTapGesture {
                        withAnimation {
                            isTermsExpanded.toggle()
                        }
                    }
                    
                    if isTermsExpanded {
                        Text("""
                        Voucher 11.000 IDR Off
                        
                        Only valid for 11 selected services:
                        - Bike Rental
                        - Auto Detailing & Wash
                        - Face Treatment
                        - Water Sport
                        - Makeup & Hairdo
                        - Massage & Spa
                        - Nail
                        - Shoe Cleaning
                        - Tutoring / Classes
                        - House Cleaning
                        - Pet Grooming
                        
                        Minimum booking of 110.000 IDR
                        1 Time use only per service list
                        """)
                        .font(.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color("MainColor3"))
                        .padding(.top, 4)
                    }
                    
                    Divider()
                        .frame(height: 0.2)
                        .background(Color("MainColor3").opacity(0.3))
                        .padding(.vertical, 10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                HStack {
                    Text(coupon.code)
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(Color("MainColor2"))
                        .padding(.leading, 16)
                    
                    Spacer()
                    
                    Button(action: {
                        UIPasteboard.general.string = coupon.code
                        showCopiedAlert = true
                    }) {
                        Image(systemName: "doc.on.doc")
                            .foregroundColor(Color("MainColor2"))
                            .padding(.trailing, 16)
                    }
                    .alert(isPresented: $showCopiedAlert) {
                        Alert(title: Text("Copied!"), message: Text("Code \(coupon.code) has been copied to clipboard."), dismissButton: .default(Text("OK")))
                    }
                }
                .frame(height: 50)
                .background(Color("MainColor2").opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .padding(.top, 0)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(labelText: coupon.title))
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    DetailCoupons(coupon: Coupon(id: "1", description: "Discount up to 50%", title: "Coupon Title", valid: Date(), image: "deals1", code: "COUPON123"))
}

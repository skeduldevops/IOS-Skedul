//
//  PartnerDetailMain.swift
//  Skedul
//
//  Created by skedul on 18/12/24.
//

import SwiftUI

struct PartnerDetailMain: View {
    var body: some View {
        

            
   PartnerDetailImage(imageName: "partnerimage")
            .padding(.top, 0)
        
            VStack(spacing: 20){
                
                PartnerDetailDescription(title: "The Menorah Beauty", rating: "0.0", reviews: "100", address: "jalan pulau kawe Gang I, Denpasar, Indonesia, 80229")
                
                Divider()
                    .foregroundColor(Color("MainColor3"))
                
                StrokeDropdownForm(label: "Type of service", dropdownItems: ["You come to us", "We come to you"], defaultValue: "You come to us")
                
                Divider()
                    .foregroundColor(Color("MainColor3"))
                
                PartnerDetailCardMenu(title: "Bali Massage", description: "Bali massage its a great way to relax and uwind", price: "1.000.000", imageName: "partnerimage")
                
            }
            .padding()
        }
}

#Preview {
    PartnerDetailMain()
}

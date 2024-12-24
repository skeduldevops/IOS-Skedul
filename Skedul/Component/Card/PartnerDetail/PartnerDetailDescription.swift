//
//  PartnerDetailDescription.swift
//  Skedul
//
//  Created by skedul on 17/12/24.
//

import SwiftUI

struct PartnerDetailDescription: View {
    let title: String
    let rating: String
    let reviews: String
    let address: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text(title)
                .font(.custom("Poppins-Bold", size: 30))
                .foregroundColor(Color("MainColor2"))
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 10) {
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color("MainColor2"))
                Text("\(rating) | \(reviews) reviews")
                    .font(.subheadline)
                    .foregroundColor(Color("MainColor3"))
            }

            HStack(alignment: .top, spacing: 10) {
                Image(systemName: "mappin.and.ellipse")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color("MainColor3"))
                Text(address)
                    .font(.subheadline)
                    .foregroundColor(Color("MainColor3"))
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

extension PartnerDetailDescription {
    static func previewExample() -> PartnerDetailDescription {
        return PartnerDetailDescription(
            title: "Your Title Goes Here",
            rating: "0.0",
            reviews: "1.000",
            address: "Perumahan Griya City Bali"
        )
    }
}

#Preview {
    PartnerDetailDescription.previewExample()
}

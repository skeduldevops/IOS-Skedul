//
//  PartnerDetailImage.swift
//  Skedul
//
//  Created by skedul on 17/12/24.
//

import SwiftUI

struct PartnerDetailImage: View {
    var imageName: String

    var body: some View {
        ZStack(alignment: .top) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 280)
 

            HStack {
                Button(action: {
                    print("Back button tapped")
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                }
                
                Spacer()
                HStack(spacing: 10) {
                    Button(action: {
                        print("Heart button tapped")
                    }) {
                        Image(systemName: "heart")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                    }

                    Button(action: {
                        print("Share button tapped")
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                    }
                }
            }
            .padding([.leading, .trailing], 20)
        }
    }
}

#Preview {
    PartnerDetailImage(imageName: "partnerimage")
}

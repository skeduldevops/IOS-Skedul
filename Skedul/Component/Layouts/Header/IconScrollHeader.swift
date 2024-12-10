//
//  IconScrollHeader.swift
//  Skedul
//
//  Created by skedul on 12/11/24.
//

import SwiftUI

struct IconScrollHeader: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(SubcategoryIcon.allIcons) { icon in
                    VStack {
                        Image(icon.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                    }
                }
            }
        }
    }
}

#Preview{
    IconScrollHeader()
}


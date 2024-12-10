//
//  SearchFields.swift
//  Skedul
//
//  Created by skedul on 12/11/24.
//

import SwiftUI

struct SearchFields: View {
    @State private var searchText: String = ""
    var body: some View {
          HStack {
              Image(systemName: "magnifyingglass")
                  .foregroundColor(Color("MainColor2"))
                  .padding(.leading, 20)
                  .frame(height: 35)
              
              TextField("Search for service provider", text: $searchText)
                  .padding(.vertical, 10)
                  .padding(.horizontal, 5)
                  .font(.custom("Poppins-Reguler", size: 15))
                  .foregroundColor(Color("MainColor2"))
          }
          .frame(height: 45)
          .background(Color(.systemGray6))
          .cornerRadius(25)
      }
}

#Preview {
    SearchFields()
}

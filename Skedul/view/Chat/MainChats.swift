//
//  MainChats.swift
//  Skedul
//
//  Created by skedul on 11/12/24.
//

import SwiftUI

struct MainChats: View {
    var body: some View {
        VStack {
            
            ChatIconMenu()
            
            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }}

#Preview {
    MainChats()
}

//
//  AboutView.swift
//  Skedul
//
//  Created by skedul on 07/11/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 1) {
                NavigationButton(title: "Term of Use", destination: TermUse())
                NavigationButton(title: "Privacy Policy", destination: Policy())
                NavigationButton(title: "Service Level Agreement", destination: SLA())
                
                Spacer()
            }
        }.padding()
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(labelText: "About"))
    }
}

struct NavigationButton<Destination: View>: View {
    let title: String
    let destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Text(title)
                    .font(.custom("Poppins-Regular", size: 16))
                    .foregroundColor(Color("MainColor2"))
                Spacer()
                    .foregroundColor(Color("MainColor3").opacity(0.2))
                
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.gray)
            }
            .padding()
            .background(Color.white)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color("MainColor3").opacity(0.2)),
                alignment: .bottom
            )
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AboutView()
}

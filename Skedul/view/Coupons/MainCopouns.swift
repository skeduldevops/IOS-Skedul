//
//  MainCopouns.swift
//  Skedul
//
//  Created by skedul on 07/11/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct MainCopouns: View {
    let images = ["deals1", "deals2"]
    @State private var currentIndex = 0
    @State private var timer: Timer?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 1) {
                    HStack {
                        Text("Deals")
                            .font(.custom("Poppins-Bold", size: 28))
                            .foregroundColor(Color("MainColor2"))
                        Spacer()
                    }
                    .padding(.leading, 20)
                    .padding(.vertical, 0)
                    
                    ZStack(alignment: .bottom) {
                        TabView(selection: $currentIndex) {
                            ForEach(images.indices, id: \.self) { index in
                                Image(images[index])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: UIScreen.main.bounds.height * 0.3)
                                    .clipped()
                                    .tag(index)
                                    .padding(.top, 30)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .frame(maxWidth: .infinity)
                        .animation(.easeInOut(duration: 0.5), value: currentIndex)
                        
                        HStack(spacing: 5) {
                            ForEach(images.indices, id: \.self) { index in
                                Circle()
                                    .fill(index == currentIndex ? Color.white : Color.white.opacity(0.3))
                                    .frame(width: 6, height: 6)
                            }
                        }
                        .padding(.bottom, 20)
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .frame(height: 250)
                    .padding(.horizontal, 0)
                    
                    CouponsCardView()
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(labelText: "Coupons"))
        .onAppear {
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                currentIndex = (currentIndex + 1) % images.count
            }
        }
    }
}

#Preview {
    MainCopouns()
}

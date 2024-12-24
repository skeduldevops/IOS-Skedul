import SwiftUI

struct PopUpNewRegisterPartner: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image("PopupSuccess")
                .resizable()
                .scaledToFit()
                .frame(width: 320, height: 320)
                .padding(.bottom, 25)
            
            Text("Congratulations,")
                .font(.custom("Poppins-Reguler", size: 24))
                .foregroundColor(Color("MainColor2"))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 45)
            
            Text("Your Partner Account Is Under Review")
                .font(.custom("Poppins-Bold", size: 24))
                .foregroundColor(Color("MainColor2"))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 45)
            
            Text("Our Partner Team will verifying your business on 3 business days")
                .font(.custom("Poppins-Reguler", size: 16))
                .foregroundColor(Color("MainColor3"))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 65)
                .padding(.top, 10)
            
            NavigationLink(destination: MainUser(), label: {
                                Text("Home")
                                    .font(.custom("Poppins-Bold", size: 20))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color("MainColor2"))
                                    .cornerRadius(10)
                                    .padding(.top, 20)
                            })
                            .isDetailLink(false)
                        }
                        .padding()
                        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    PopUpNewRegisterPartner()
}

import SwiftUI

struct PartnerDetailCardMenu: View {

    let mainColor3 = Color("MainColor3")
    let mainColor2 = Color("MainColor2")

    let title: String
    let description: String
    let price: String
    var imageName: String
    let buttonWidth: CGFloat = 180

    var body: some View {
        VStack {
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(height: 180)
                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 4, y: 4)
                .overlay(
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(title)
                                .font(.custom("Poppins-Bold", size: 18))
                                .foregroundColor(mainColor2)
                                .lineLimit(1)

                            Text(description)
                                .font(.custom("Poppins-Regular", size: 14))
                                .foregroundColor(mainColor3)
                                .lineLimit(2)
                                .truncationMode(.tail)

                            Text(price)
                                .font(.custom("Poppins-Medium", size: 16))
                                .foregroundColor(mainColor2)
                        }
                        .padding(.vertical, 16)

                        Spacer()

                        VStack {
                            ZStack {
                                Image(imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))

                                Button(action: {
                                }) {
                                    Text("View")
                                        .font(.custom("Poppins-Regular", size: 14))
                                        .foregroundColor(mainColor2)
                                        .frame(width: 80, height: 12)
                                        .padding(10)
                                        .background(Color.white)
                                        .cornerRadius(15)
                                        .shadow(color: mainColor3.opacity(2), radius: 3, x: 0, y: 2)
                                }
                                .offset(y: 50)
                            }
                        }
                    }
                    .padding()
                )
        }
    }
}

struct PartnerDetailCardMenu_Previews: PreviewProvider {
    static var previews: some View {
        PartnerDetailCardMenu(
            title: "Partner Title",
            description: "This is a detailed description of the partner service. If the description is too long, it will truncate with an ellipsis.",
            price: "$99.99",
            imageName: "partnerimage"
        )
        .previewLayout(.sizeThatFits)
    }
}

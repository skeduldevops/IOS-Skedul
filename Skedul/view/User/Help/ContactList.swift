import SwiftUI

struct ContactList: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Whatsapp")
                .font(Font.custom("Poppins-Bold", size: 14))
                .foregroundColor(Color("MainColor2"))
                .multilineTextAlignment(.leading)
            
            Text("+62 818-0458-8222")
                .font(Font.custom("Poppins-Reguler", size: 14))
                .foregroundColor(Color("MainColor2"))
                .multilineTextAlignment(.leading)
            
            Divider()
                .background(Color("MainColor3"))
                .opacity(0.3)
                .padding(.vertical, 10)
        
            
            Text("Email")
                .font(Font.custom("Poppins-Bold", size: 14))
                .foregroundColor(Color("MainColor2"))
                .multilineTextAlignment(.leading)
            
            Text("official@skedul.com")
                .font(Font.custom("Poppins-Reguler", size: 14))
                .foregroundColor(Color("MainColor2"))
                .multilineTextAlignment(.leading)
            
            Divider()
                .background(Color("MainColor3"))
                .opacity(0.3)
                .padding(.vertical, 10)
            
            Text("Website")
                .font(Font.custom("Poppins-Bold", size: 14))
                .foregroundColor(Color("MainColor2"))
                .multilineTextAlignment(.leading)
            
            Text("www.skedul.com")
                .font(Font.custom("Poppins-Reguler", size: 14))
                .foregroundColor(Color("MainColor2"))
                .multilineTextAlignment(.leading)
            
            Divider()
                .background(Color("MainColor3"))
                .opacity(0.3)
                .padding(.vertical, 10)
            
            Text("Address")
                .font(Font.custom("Poppins-Bold", size: 14))
                .foregroundColor(Color("MainColor2"))
                .multilineTextAlignment(.leading)
            
            Text("Jln Raya Bypass, Kediri Nomor 24, Banjar Anyar, Kecamatan Kediri, Kabupaten Tabanan, 82121")
                .font(Font.custom("Poppins-Light", size: 14))
                .foregroundColor(Color("MainColor2"))
                .multilineTextAlignment(.leading)
                .padding(.bottom, 65)
                .frame(width: 360, alignment: .leading)
            
            Text("Directorate General of Consumer Protection and Trade Compliance")
                .font(Font.custom("Poppins-Light", size: 14))
                .foregroundColor(Color("MainColor2"))
                .multilineTextAlignment(.leading)
                .frame(width: 360, alignment: .leading)
            
            Text("Ministry of Trade of the Republic of Indonesia 0853-111-1010 (Whatsapp)")
                .font(Font.custom("Poppins-Light", size: 14))
                .foregroundColor(Color("MainColor2"))
                .multilineTextAlignment(.leading)
                .frame(width: 360, alignment: .leading)
            
            Spacer()
            
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    ContactList()
}

//
//  DateForm.swift
//  Skedul
//
//  Created by skedul on 30/10/24.
//

import SwiftUI

struct DateForm: View {
    var label: String
    var placeholder: String
    @Binding var date: Date
    var MainColor: Color = Color("MainColor2")
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(label)
                .font(.custom("Poppins-Medium", size: 14))
                .padding(.top, 12)
            
            HStack {
                DatePicker("", selection: $date, displayedComponents: .date)
                    .labelsHidden()
                    .frame(height: 15)
                    .foregroundColor(MainColor)
                
                Spacer()
                
                Image(systemName: "calendar")
                    .foregroundColor(MainColor)
                    .padding(.trailing)
                    .frame(width: 20, height: 20)
            }
            .padding()
            .background(Color.white)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(MainColor, lineWidth: 1.5))
            .cornerRadius(15)
        }
        .padding(.bottom, 7)
    }
}


struct DateForm_Previews: PreviewProvider {
    static var previews: some View {
        DateForm(label: "Date Of Birth", placeholder: "Enter Date of Birth", date: .constant(Date()))
    }
}

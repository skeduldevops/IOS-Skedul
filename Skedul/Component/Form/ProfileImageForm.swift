//
//  ProfileImageForm.swift
//  Skedul
//
//  Created by skedul on 30/10/24.
//

import SwiftUI

struct ProfileImageForm: View {
    @State private var isImagePickerPresented = false
    @State private var profileImage: Image? = nil
    @Binding var selectedImage: UIImage? // Mengikat gambar untuk diupload
    @State private var isImageUploaded = false // Menyimpan status upload
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if let profileImage = profileImage {
                profileImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color(.white), lineWidth: 1)
                    )
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundColor(Color("MainColor2"))
                    .frame(width: 100, height: 100)
            }
            
            Image(systemName: "pencil.circle.fill")
                .resizable()
                .foregroundColor(Color("MainColor2"))
                .frame(width: 30, height: 30)
                .background(Color.white.clipShape(Circle()))
                .offset(x: -10, y: -0)
                .onTapGesture {
                    isImagePickerPresented.toggle()
                }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: Binding<UIImage?>(
                get: { selectedImage },
                set: { newImage in
                    selectedImage = newImage
                    if let _ = newImage {
                        profileImage = Image(uiImage: newImage!)
                    }
                }
            ))
        }
    }
}

#Preview {
    ProfileImageForm(selectedImage: .constant(nil))
}

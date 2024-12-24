import SwiftUI
import UIKit

struct ImageUploadForm: View {
    var label: String
    var placeholder1: String
    var placeholder2: String
    @Binding var selectedImage: UIImage?
    var buttonHeight: CGFloat = 100

    @State private var isImagePickerPresented = false
    @State private var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.custom("Poppins-Medium", size: 16))
                .padding(.top, 12)
                .foregroundColor(Color("MainColor2"))

            Button(action: {
                isImagePickerPresented.toggle()
            }) {
                VStack {
                    Text(placeholder1)
                        .font(.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color("MainColor3"))
                    Text(placeholder2)
                        .font(.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color("MainColor2"))
                }
                .frame(height: buttonHeight)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [5]))
                        .foregroundColor(Color("MainColor2"))
                )
                .cornerRadius(15)
            }
            .frame(maxWidth: .infinity)
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePickerView(selectedImage: $selectedImage, sourceType: imagePickerSourceType)
            }
        }
        .padding(.bottom, 5)
    }
}

struct ImagePickerView: View {
    @Binding var selectedImage: UIImage?
    var sourceType: UIImagePickerController.SourceType

    var body: some View {
        ImagePickerControllerWrapper(selectedImage: $selectedImage, sourceType: sourceType)
    }
}

struct ImagePickerControllerWrapper: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    var sourceType: UIImagePickerController.SourceType

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var selectedImage: UIImage?

        init(selectedImage: Binding<UIImage?>) {
            _selectedImage = selectedImage
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                selectedImage = image
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedImage: $selectedImage)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct ImageUploadForm_Previews: PreviewProvider {
    static var previews: some View {
        ImageUploadForm(
            label: "Certification",
            placeholder1: "Max file size: 10 MB",
            placeholder2: "Upload Certification",
            selectedImage: .constant(nil)
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

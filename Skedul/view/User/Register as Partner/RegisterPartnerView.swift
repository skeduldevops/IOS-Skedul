import FirebaseFirestore
import FirebaseStorage
import SwiftUI
import FirebaseAuth
import Firebase

struct RegisterPartnerView: View {

  @State private var businessName = ""
  @State private var partnerName = ""
  @State private var phoneNumber = ""
  @State private var npwp = ""
  @State private var nib = ""
  @State private var category = ""
  @State private var subcategory = ""
  @State private var categories: [String] = []
  @State private var subcategories: [String] = []
  @State private var certification: UIImage?
  @State private var images: UIImage?
  @State private var isPartnerDataSaved = false 

  private var db = Firestore.firestore()

  var body: some View {
    VStack {
      ScrollView {
        DropdownForm(
          label: "Category", options: categories, selectedOption: $category,
          onChange: {
            subcategory = ""
            loadSubcategories()
          }
        )

        DropdownForm(
          label: "Service Type", options: subcategories, selectedOption: $subcategory
        )

        FillForm(
          label: "Partner's Business Name", placeholder: "Enter Business Name", text: $businessName
        )

        FillForm(
          label: "Partner's Name", placeholder: "Enter Partner's Name", text: $partnerName
        )

        PhoneForm(
          label: "Phone Number", placeholder: "Enter Phone Number", number: $phoneNumber
        )

        NumberForm(
          label: "NPWP (Optional)", placeholder: "Enter NPWP", number: $npwp
        )

        NumberForm(
          label: "NIB (Optional)", placeholder: "Enter NIB", number: $nib
        )

        ImageUploadForm(
          label: "Certification",
          placeholder1: "Upload Certification, Up to 5 Certification",
          placeholder2: "Max file size: 10 MB",
          selectedImage: $certification
        )

        ImageUploadForm(
          label: "Images",
          placeholder1: "Upload Image, Up to 5 Images",
          placeholder2: "Max file size: 10 MB",
          selectedImage: $images
        )

        PrimaryButton(
          label: "Save",
          action: {
            savePartnerData()
          }
        )
      }
      .padding()
      .navigationBarBackButtonHidden(true)
      .navigationBarItems(
        leading: BackButton(labelText: "Login & Security")
      )
      .onAppear {
        loadCategories(db: db, categories: $categories)
      }
        
      NavigationLink(
        destination: PopUpNewRegisterPartner(),
        isActive: $isPartnerDataSaved
      ) {
        EmptyView()
      }
    }
  }

  private func loadSubcategories() {
    guard !category.isEmpty else {
      subcategories = []
      return
    }

    loadSubcategoriesFromCategory(
      db: db,
      category: category,
      subcategories: $subcategories
    )
  }

  private func uploadImageToStorage(
    image: UIImage,
    folderName: String,
    completion: @escaping (String?) -> Void
  ) {
    guard let imageData = image.jpegData(compressionQuality: 0.75) else {
      completion(nil)
      return
    }

    let storageRef = Storage.storage().reference().child(
      "\(folderName)/\(UUID().uuidString).jpg"
    )

    storageRef.putData(imageData, metadata: nil) { metadata, error in
      if let error = error {
        print("Error uploading image: \(error.localizedDescription)")
        completion(nil)
      } else {
        storageRef.downloadURL { url, error in
          if let error = error {
            print("Error getting download URL: \(error.localizedDescription)")
            completion(nil)
          } else if let url = url {
            completion(url.absoluteString)
          }
        }
      }
    }
  }

  private func savePartnerData() {
    uploadImageToStorage(
      image: certification ?? UIImage(),
      folderName: "certifications"
    ) { certificationURL in
      guard let certificationURL = certificationURL else {
        print("Failed to upload certification image.")
        return
      }

      uploadImageToStorage(
        image: images ?? UIImage(),
        folderName: "partner_images"
      ) { imageURL in
        guard let imageURL = imageURL else {
          print("Failed to upload partner image.")
          return
        }

        let partnerData: [String: Any] = [
          "businessName": businessName,
          "partnerName": partnerName,
          "phoneNumber": phoneNumber,
          "npwp": npwp,
          "nib": nib,
          "category": category,
          "subcategory": subcategory,
          "status": "reviewing",
          "certificationImageURL": certificationURL,
          "imageURL": imageURL,
          "users_id": Auth.auth().currentUser?.uid ?? "",
          "services_id": "",
          "createdAt": Timestamp()
        ]

        db.collection("Services").addDocument(data: partnerData) { error in
          if let error = error {
            print("Error adding document: \(error.localizedDescription)")
            return
          } else {
            print("Partner data successfully saved!")
            db.collection("Services").whereField("businessName", isEqualTo: businessName)
              .whereField("partnerName", isEqualTo: partnerName)
              .getDocuments { snapshot, error in
                if let error = error {
                  print("Error retrieving Services document: \(error.localizedDescription)")
                } else if let document = snapshot?.documents.first {
                  var updatedPartnerData = partnerData
                  updatedPartnerData["services_id"] = document.documentID
                  db.collection("Services").document(document.documentID).setData(updatedPartnerData, merge: true) { error in
                    if let error = error {
                      print("Error updating services_id: \(error.localizedDescription)")
                    } else {
                      print("services_id successfully added to Services document.")
                      isPartnerDataSaved = true
                    }
                  }
                }
              }
          }
        }
      }
    }
  }
}


#Preview {
  RegisterPartnerView()
}

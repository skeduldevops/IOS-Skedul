//saya ingin kamu membuatkan fungsi filtering dimana sesuai dengan SubCategory yang dipilih misalnya SubCategory yang dipilih jika yang diplih Message & Spa maka fetching data sesuai dengan Message & Spa yang muncul, ubahkan dan tuliskan terpisah yang perlu diupdate, tuliskan kembali semuanya terpisah dan saya ingin copy paste pastikan berfungsi semuanya jangan mengubah style dan menghilangkan dan mengubah appaun yang saya minta,jangan ada error yaa babi anjing
//
//import Foundation
//
//struct Partner: Identifiable, Decodable {
//    var id: String
//    var partnerName: String
//    var partnerEmail: String
//    var businessName: String
//    var address: String?
//    var phone: String?
//    var typeCategory: String?
//    var typeSubcategory: String?
//    var created: String?
//    var statusApproval: String?
//    var image: String?
//    var npwp: String?
//    var nib: String?
//    var totalReview: String?
//    var filterRating: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case partnerName = "partner_name"
//        case partnerEmail = "partner_email"
//        case businessName = "business_name"
//        case address = "address"
//        case phone
//        case typeCategory = "type_category"
//        case typeSubcategory = "type_subcategory"
//        case created
//        case statusApproval = "status_approval"
//        case image
//        case npwp
//        case nib
//        case totalReview = "total_review"
//        case filterRating = "filter_rating"
//    }
//}
//
////
////  SubcategoryIcon.swift
////  Skedul
////
////  Created by skedul on 12/11/24.
////
//
//import Foundation
//
//struct SubcategoryIcon: Identifiable {
//    let id = UUID()
//    let imageName: String
//    
//    static let allIcons: [SubcategoryIcon] = [
//        SubcategoryIcon(imageName: "My Favorit"),
//        SubcategoryIcon(imageName: "House Cleaning"),
//        SubcategoryIcon(imageName: "AC Service"),
//        SubcategoryIcon(imageName: "Pet Grooming"),
//        SubcategoryIcon(imageName: "Barber"),
//        SubcategoryIcon(imageName: "Make-Up & Hair-Do"),
//        SubcategoryIcon(imageName: "Massage & Spa"),
//        SubcategoryIcon(imageName: "Nail"),
//        SubcategoryIcon(imageName: "Eyelashes"),
//        SubcategoryIcon(imageName: "Eyebrow"),
//        SubcategoryIcon(imageName: "Face Treatment"),
//        SubcategoryIcon(imageName: "IV Booster"),
//        SubcategoryIcon(imageName: "Fitness Class"),
//        SubcategoryIcon(imageName: "Auto Detailing & Wash"),
//        SubcategoryIcon(imageName: "BIke Rental"),
//        SubcategoryIcon(imageName: "Personal Trainer"),
//        SubcategoryIcon(imageName: "Shoe Cleaning"),
//        SubcategoryIcon(imageName: "Sports Lessons : Coach"),
//        SubcategoryIcon(imageName: "Music Lessons"),
//        SubcategoryIcon(imageName: "Tutoring : Classes"),
//        SubcategoryIcon(imageName: "Fishing"),
//        SubcategoryIcon(imageName: "Diving & Marine Activities")
//    ]
//}
//
////
////  MainService.swift
////  Skedul
////
////  Created by skedul on 08/11/24.
////
//
//import SwiftUI
//import Firebase
//
//struct MainService: View {
//    @State private var expandedMenuID: String? = nil
//    @State private var categories: [Category] = []
//    @State private var selectedSubcategory: String? = nil
//    
//    var body: some View {
//        
//        VStack {
//            SearchFields()
//                .padding(.horizontal, 15)
//            
//            HStack {
//                Text("Service List")
//                    .font(.custom("Poppins-Bold", size: 28))
//                    .foregroundColor(Color("MainColor2"))
//                Spacer()
//            }
//            .padding(.leading, 20)
//            .padding(.bottom, 1)
//        }
//        
//        NavigationView {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 16) {
//                    ForEach(categories) { category in
//                        MenuView(
//                            iconName: category.categoryIcon,
//                            menuName: category.category,
//                            submenuItems: category.subCategory.map { SubmenuItem(iconName: "star", name: $0) },
//                            isExpanded: expandedMenuID == category.id,
//                            onToggle: {
//                                expandedMenuID = expandedMenuID == category.id ? nil : category.id
//                            },
//                            onSubmenuSelect: { selectedSubcategory = $0 }
//                        )
//                    }
//                }
//                .padding()
//                .onAppear(perform: loadCategories)
//                                NavigationLink(
//                    destination: PartnerList(selectedSubcategory: $selectedSubcategory),
//                    isActive: Binding(
//                        get: { selectedSubcategory != nil },
//                        set: { newValue in
//                            if !newValue {
//                            }
//                        }
//                    )
//                ) { EmptyView() }
//            }
//            .onDisappear {
//                expandedMenuID = nil
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//
//    private func loadCategories() {
//        let db = Firestore.firestore()
//        db.collection("Category").getDocuments { (snapshot, error) in
//            if let error = error {
//                print("Error fetching categories: \(error)")
//                return
//            }
//            if let snapshot = snapshot {
//                self.categories = snapshot.documents.compactMap { document in
//                    let data = document.data()
//                    let id = document.documentID
//                    let category = data["Category"] as? String ?? ""
//                    let categoryIcon = data["Category_Icon"] as? String ?? ""
//                    let subCategory = data["SubCategory"] as? [String] ?? []
//                    
//                    return Category(id: id, category: category, categoryIcon: categoryIcon, subCategory: subCategory)
//                }
//            }
//        }
//    }
//}
//
//struct MenuView: View {
//    let iconName: String
//    let menuName: String
//    let submenuItems: [SubmenuItem]
//    let isExpanded: Bool
//    let onToggle: () -> Void
//    let onSubmenuSelect: (String) -> Void
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            HStack {
//                Image(iconName)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 22, height: 22)
//
//                Text(menuName)
//                    .font(.custom("Poppins-SemiBold", size: 15))
//                    .foregroundColor(Color("MainColor2"))
//                Spacer()
//                Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
//                    .padding(.trailing, 8)
//                    .foregroundColor(Color("MainColor3"))
//            }
//            .padding()
//            .onTapGesture {
//                onToggle()
//            }
//            
//            if isExpanded {
//                VStack(alignment: .leading, spacing: 8) {
//                    ForEach(submenuItems) { submenu in
//                        HStack {
//                            Image(submenu.name)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 22, height: 22)
//
//                            Text(submenu.name)
//                                .font(.custom("Poppins-SemiBold", size: 16))
//                                .foregroundColor(Color("MainColor2"))
//                            Spacer()
//                            Image(systemName: "chevron.right")
//                                .foregroundColor(Color("MainColor3"))
//                                .padding(.trailing, 10)
//                        }
//                        .padding(.leading, 25)
//                        .onTapGesture {
//                            onSubmenuSelect(submenu.name)
//                        }
//                    }
//                    .padding(.top, 12)
//                    .padding(.bottom, 10)
//                }
//                .padding(.bottom, 10)
//                .background(Color.white)
//                .cornerRadius(10)
//                .padding(.horizontal)
//            }
//        }
//        .background(Color.white)
//        .cornerRadius(10)
//        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
//        .overlay(
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(Color("MainColor2"), lineWidth: 0.1)
//        )
//    }
//}
//
//struct SubmenuItem: Identifiable {
//    let id = UUID()
//    let iconName: String
//    let name: String
//}
//
//#Preview {
//    MainService()
//}
//
////
////  PartnerList.swift
////  Skedul
////
////  Created by skedul on 08/11/24.
////
//
//import SwiftUI
//
//struct PartnerList: View {
//    @Binding var selectedSubcategory: String?
//    @State private var partners: [Partner] = []
//    @State private var errorMessage: String?
//    @State private var isLoading = false
//    @State private var imageCache: [String: URL] = [:]
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                
//                if isLoading {
//                    ProgressView("Loading...")
//                        .progressViewStyle(CircularProgressViewStyle())
//                        .padding()
//                } else if let errorMessage = errorMessage {
//                    Text("Error: \(errorMessage)")
//                        .foregroundColor(.red)
//                        .padding()
//                } else {
//                    List(partners) { partner in
//                        VStack {
//                            HStack {
//                                Group {
//                                    if let imageUrl = partner.image, !imageUrl.isEmpty, let url = URL(string: imageUrl) {
//                                        if let cachedImageUrl = imageCache[imageUrl] {
//                                            Image(uiImage: UIImage(contentsOfFile: cachedImageUrl.path) ?? UIImage())
//                                                .resizable()
//                                                .aspectRatio(contentMode: .fill)
//                                                .frame(width: 80, height: 80)
//                                                .clipShape(RoundedRectangle(cornerRadius: 15))
//                                                .clipped()
//                                        } else {
//                                            AsyncImage(url: url) { phase in
//                                                switch phase {
//                                                case .empty:
//                                                    ProgressView()
//                                                        .frame(width: 50, height: 50)
//                                                case .success(let image):
//                                                    image
//                                                        .resizable()
//                                                        .aspectRatio(contentMode: .fill)
//                                                        .frame(width: 80, height: 80)
//                                                        .clipShape(RoundedRectangle(cornerRadius: 15))
//                                                        .clipped()
//                                                case .failure:
//                                                    Image("default_image_name")
//                                                        .resizable()
//                                                        .scaledToFill()
//                                                        .frame(width: 80, height: 80)
//                                                        .clipShape(RoundedRectangle(cornerRadius: 15))
//                                                @unknown default:
//                                                    EmptyView()
//                                                }
//                                            }
//                                            .onAppear {
//                                                loadImageAndCache(url: url, imageUrl: imageUrl)
//                                            }
//                                        }
//                                    } else {
//                                        Image("default")
//                                            .resizable()
//                                            .scaledToFill()
//                                            .frame(width: 80, height: 80)
//                                            .clipShape(RoundedRectangle(cornerRadius: 15))
//                                    }
//                                }
//                                
//                                VStack(alignment: .leading) {
//                                    Text(partner.businessName)
//                                        .foregroundColor(Color("MainColor2"))
//                                        .font(.custom("Poppins-Bold", size: 14))
//                                        .padding(.bottom, 2)
//                                    
//                                    HStack {
//                                        Image(systemName: "star.fill")
//                                            .foregroundColor(Color("MainColor2"))
//                                        
//                                        Text("-")
//                                            .font(.custom("Poppins-Reguler", size: 14))
//                                            .foregroundColor(Color("MainColor3"))
//                                        
//                                        Text(" | 0 reviews")
//                                            .font(.custom("Poppins-Reguler", size: 12))
//                                            .foregroundColor(Color("MainColor3"))
//                                    }
//                                    .padding(.top, 5)
//                                }
//                                .padding(.leading, 8)
//                                .padding(.trailing, 8)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                            }
//                            .padding(10)
//                            .background(Color.white)
//                            .cornerRadius(15)
//                            .shadow(radius: 3)
//                            .frame(maxWidth: .infinity, minHeight: 100)
//                        }
//                        .padding(.horizontal, 0)
//                    }
//                    .listStyle(PlainListStyle())
//                }
//            }
//            .onAppear {
//                fetchData()
//            }
//            .padding(.top, 10)
//        }
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: BackButton(labelText: "Service List", destination: AnyView(MainService())))
//    }
//
//    private func fetchData() {
//        isLoading = true
//        APIService.shared.fetchPartners(subcategory: selectedSubcategory ?? "") { result in
//            switch result {
//            case .success(let partners):
//                self.partners = partners
//            case .failure(let error):
//                self.errorMessage = error.localizedDescription
//            }
//            self.isLoading = false
//        }
//    }
//
//    private func loadImageAndCache(url: URL, imageUrl: String) {
//        if imageCache[imageUrl] == nil {
//            let task = URLSession.shared.dataTask(with: url) { data, response, error in
//                if let data = data, error == nil {
//                    if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//                        let fileURL = documentsDirectory.appendingPathComponent(imageUrl)
//                        do {
//                            try data.write(to: fileURL)
//                            DispatchQueue.main.async {
//                                self.imageCache[imageUrl] = fileURL
//                            }
//                        } catch {
//                            print("Error saving image: \(error)")
//                        }
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//}
//#Preview {
//    PartnerList(selectedSubcategory: .constant("Submenu1"))
//}
//
//import Foundation
//
//class APIService {
//    static let shared = APIService()
//
//    func fetchPartners(subcategory: String?, completion: @escaping (Result<[Partner], Error>) -> Void) {
//        guard let url = URL(string: "https://skedulapp.bubbleapps.io/api/1.1/wf/get_service") else {
//            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("Bearer f7414fff437f22769d5cd86d2a8c3456", forHTTPHeaderField: "Authorization")
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
//                return
//            }
//            
//            do {
//                let partners = try JSONDecoder().decode([Partner].self, from: data)
//                completion(.success(partners))
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
//    
//    func downloadImage(from url: URL, completion: @escaping (URL?) -> Void) {
//        let fileManager = FileManager.default
//        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let imageDirectory = documentsDirectory.appendingPathComponent("Images")
//        
//        if !fileManager.fileExists(atPath: imageDirectory.path) {
//            do {
//                try fileManager.createDirectory(at: imageDirectory, withIntermediateDirectories: true, attributes: nil)
//            } catch {
//                print("Error creating directory: \(error)")
//                completion(nil)
//                return
//            }
//        }
//        
//        let imageName = url.lastPathComponent
//        let imagePath = imageDirectory.appendingPathComponent(imageName)
//        
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            if let data = data, error == nil {
//                do {
//                    try data.write(to: imagePath)
//                    completion(imagePath)
//                } catch {
//                    print("Error saving image: \(error)")
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }.resume()
//    }
//}

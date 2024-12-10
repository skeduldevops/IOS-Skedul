//
//  PartnerList.swift
//  Skedul
//
//  Created by skedul on 08/11/24.
//

import SwiftUI

struct PartnerList: View {
    @Binding var selectedSubcategory: String?
    @State private var partners: [Partner] = []
    @State private var errorMessage: String?
    @State private var isLoading = false
    @State private var imageCache: [String: URL] = [:]

    var body: some View {
        NavigationView {
            VStack {
                
                if isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(partners) { partner in
                        VStack {
                            HStack {
                                Group {
                                    if let imageUrl = partner.image, !imageUrl.isEmpty, let url = URL(string: imageUrl) {
                                        if let cachedImageUrl = imageCache[imageUrl] {
                                            Image(uiImage: UIImage(contentsOfFile: cachedImageUrl.path) ?? UIImage())
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 80, height: 80)
                                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                                .clipped()
                                        } else {
                                            AsyncImage(url: url) { phase in
                                                switch phase {
                                                case .empty:
                                                    ProgressView()
                                                        .frame(width: 50, height: 50)
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 80, height: 80)
                                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                                        .clipped()
                                                case .failure:
                                                    Image("default_image_name")
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 80, height: 80)
                                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                                @unknown default:
                                                    EmptyView()
                                                }
                                            }
                                            .onAppear {
                                                loadImageAndCache(url: url, imageUrl: imageUrl)
                                            }
                                        }
                                    } else {
                                        Image("default")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 80, height: 80)
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                    }
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(partner.businessName)
                                        .foregroundColor(Color("MainColor2"))
                                        .font(.custom("Poppins-Bold", size: 14))
                                        .padding(.bottom, 2)
                                    
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(Color("MainColor2"))
                                        
                                        Text("-")
                                            .font(.custom("Poppins-Reguler", size: 14))
                                            .foregroundColor(Color("MainColor3"))
                                        
                                        Text(" | 0 reviews")
                                            .font(.custom("Poppins-Reguler", size: 12))
                                            .foregroundColor(Color("MainColor3"))
                                    }
                                    .padding(.top, 5)
                                }
                                .padding(.leading, 8)
                                .padding(.trailing, 8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 3)
                            .frame(maxWidth: .infinity, minHeight: 100)
                        }
                        .padding(.horizontal, 0)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .onAppear {
                fetchData()
            }
            .padding(.top, 10)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(labelText: "Service List", destination: AnyView(MainService())))
    }

    private func fetchData() {
        isLoading = true
        APIService.shared.fetchPartners(subcategory: selectedSubcategory ?? "") { result in
            switch result {
            case .success(let partners):
                self.partners = partners
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }

    private func loadImageAndCache(url: URL, imageUrl: String) {
        if imageCache[imageUrl] == nil {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, error == nil {
                    if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                        let fileURL = documentsDirectory.appendingPathComponent(imageUrl)
                        do {
                            try data.write(to: fileURL)
                            DispatchQueue.main.async {
                                self.imageCache[imageUrl] = fileURL
                            }
                        } catch {
                            print("Error saving image: \(error)")
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
#Preview {
    PartnerList(selectedSubcategory: .constant("Submenu1"))
}

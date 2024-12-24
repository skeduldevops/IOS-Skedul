//
//  ServicesListView.swift
//  Skedul
//
//  Created by skedul on 23/12/24.
//

import FirebaseFirestore
import FirebaseStorage
import SwiftUI

struct Service: Identifiable, Decodable {
    @DocumentID var id: String?
    var businessName: String
    var partnerName: String
    var phoneNumber: String
    var npwp: String
    var nib: String
    var category: String
    var subcategory: String
    var certificationImageURL: String
    var imageURL: String
}

struct ServicesListView: View {
    @State private var services: [Service] = []
    @State private var isLoading: Bool = true
    @State private var imageCache: [String: UIImage] = [:]
    
    private var db = Firestore.firestore()

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading services...")
                    .font(.headline)
                    .padding()
            } else {
                Text("Services List")
                    .font(.title)
                    .padding()

                ScrollView {
                    LazyVStack {
                        ForEach(services) { service in
                            VStack(alignment: .leading) {
                                Text(service.businessName)
                                    .font(.headline)
                                Text("Partner: \(service.partnerName)")
                                    .font(.subheadline)
                                Text("Phone: \(service.phoneNumber)")
                                    .font(.subheadline)

                                HStack {
                                    CachedImageView(urlString: service.certificationImageURL, cache: $imageCache)
                                        .frame(width: 100, height: 100)
                                    CachedImageView(urlString: service.imageURL, cache: $imageCache)
                                        .frame(width: 100, height: 100)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
            }
        }
        .onAppear {
            preloadData()
        }
        .padding()
    }

    private func preloadData() {
        db.collection("Services").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
            } else {
                let loadedServices = snapshot?.documents.compactMap { document in
                    try? document.data(as: Service.self)
                } ?? []
                
                preloadImages(for: loadedServices) {
                    self.services = loadedServices
                    self.isLoading = false
                }
            }
        }
    }

    private func preloadImages(for services: [Service], completion: @escaping () -> Void) {
        let urls = services.flatMap { [URL(string: $0.certificationImageURL), URL(string: $0.imageURL)] }
            .compactMap { $0 }
        
        let dispatchGroup = DispatchGroup()

        urls.forEach { url in
            dispatchGroup.enter()
            downloadImage(url: url) { _ in
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }

    private func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache[url.absoluteString] {
            completion(cachedImage)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageCache[url.absoluteString] = image
                }
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}

struct CachedImageView: View {
    let urlString: String
    @Binding var cache: [String: UIImage]
    
    var body: some View {
        if let image = cache[urlString] {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        } else {
            ProgressView()
                .onAppear {
                    loadImage()
                }
        }
    }

    private func loadImage() {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cache[urlString] = image
                }
            }
        }.resume()
    }
}



#Preview {
  ServicesListView()
}

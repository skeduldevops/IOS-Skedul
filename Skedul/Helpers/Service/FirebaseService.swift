//
//  FirebaseService.swift
//  Skedul
//
//  Created by skedul on 05/11/24.
//
/*
import Firebase
import FirebaseFirestore
import FirebaseStorage
import SwiftUI
import FirebaseCore
import FirebaseAuth

class FirebaseService: ObservableObject {
    @Published var categories: [Category] = []
    
    init() {
        fetchCategories()
    }
    
    func fetchCategories() {
        let db = Firestore.firestore()
        db.collection("your_collection_name").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching categories: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            self.categories = documents.compactMap { doc in
                let data = doc.data()
                
                guard let name = data["Category"] as? String,
                      let icon = data["Category_Icon"] as? String,
                      let subcategories = data["SubCategory"] as? [String] else {
                    return nil
                }
                
                return Category(name: name, icon: icon, subcategories: subcategories)
            }
        }
    }
    
    func fetchIcon(for categoryIcon: String, completion: @escaping (UIImage?) -> Void) {
        let storage = Storage.storage()
        let path = "category_icon/\(categoryIcon)"
        
        storage.reference(withPath: path).getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error fetching icon: \(error)")
                completion(nil)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}
 */

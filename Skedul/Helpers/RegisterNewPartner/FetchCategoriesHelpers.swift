//  FetchCategoriesHelpers.swift
//  Skedul
//
//  Created by skedul on 20/12/24.
//

import Foundation
import FirebaseFirestore
import SwiftUI

func loadCategories(db: Firestore, categories: Binding<[String]>) {
    db.collection("Category").getDocuments { snapshot, error in
        if let error = error {
            print("Error getting documents: \(error.localizedDescription)")
        } else {
            categories.wrappedValue = snapshot?.documents.compactMap { document in
                document.data()["Category"] as? String
            } ?? []
        }
    }
}

func loadSubcategoriesFromCategory(db: Firestore, category: String, subcategories: Binding<[String]>) {
    db.collection("Category").whereField("Category", isEqualTo: category).getDocuments { snapshot, error in
        if let error = error {
            print("Error getting documents: \(error.localizedDescription)")
        } else {
            subcategories.wrappedValue = snapshot?.documents.compactMap { document in
                document.data()["SubCategory"] as? [String]
            }.flatMap { $0 } ?? []
        }
    }
}


//
//  Category.swift
//  Skedul
//
//  Created by skedul on 06/11/24.
//

import Foundation

struct Category: Identifiable, Codable {
    var id: String
    var category: String
    var categoryIcon: String
    var subCategory: [String]
}

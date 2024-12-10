//
//  SubcategoryIcon.swift
//  Skedul
//
//  Created by skedul on 12/11/24.
//

import Foundation

struct SubcategoryIcon: Identifiable {
    let id = UUID()
    let imageName: String
    
    static let allIcons: [SubcategoryIcon] = [
        SubcategoryIcon(imageName: "My Favorit"),
        SubcategoryIcon(imageName: "House Cleaning"),
        SubcategoryIcon(imageName: "AC Service"),
        SubcategoryIcon(imageName: "Pet Grooming"),
        SubcategoryIcon(imageName: "Barber"),
        SubcategoryIcon(imageName: "Make-Up & Hair-Do"),
        SubcategoryIcon(imageName: "Massage & Spa"),
        SubcategoryIcon(imageName: "Nail"),
        SubcategoryIcon(imageName: "Eyelashes"),
        SubcategoryIcon(imageName: "Eyebrow"),
        SubcategoryIcon(imageName: "Face Treatment"),
        SubcategoryIcon(imageName: "IV Booster"),
        SubcategoryIcon(imageName: "Fitness Class"),
        SubcategoryIcon(imageName: "Auto Detailing & Wash"),
        SubcategoryIcon(imageName: "BIke Rental"),
        SubcategoryIcon(imageName: "Personal Trainer"),
        SubcategoryIcon(imageName: "Shoe Cleaning"),
        SubcategoryIcon(imageName: "Sports Lessons : Coach"),
        SubcategoryIcon(imageName: "Music Lessons"),
        SubcategoryIcon(imageName: "Tutoring : Classes"),
        SubcategoryIcon(imageName: "Fishing"),
        SubcategoryIcon(imageName: "Diving & Marine Activities")
    ]
}

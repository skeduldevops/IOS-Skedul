//
//  MainService.swift
//  Skedul
//
//  Created by skedul on 08/11/24.
//

import SwiftUI
import Firebase

struct MainService: View {
    @State private var expandedMenuID: String? = nil
    @State private var categories: [Category] = []
    @State private var selectedSubcategory: String? = nil
    
    var body: some View {
        
        VStack {
            SearchFields()
                .padding(.horizontal, 15)
            
            HStack {
                Text("Service List")
                    .font(.custom("Poppins-Bold", size: 28))
                    .foregroundColor(Color("MainColor2"))
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.bottom, 1)
        }
        
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(categories) { category in
                        MenuView(
                            iconName: category.categoryIcon,
                            menuName: category.category,
                            submenuItems: category.subCategory.map { SubmenuItem(iconName: "star", name: $0) },
                            isExpanded: expandedMenuID == category.id,
                            onToggle: {
                                expandedMenuID = expandedMenuID == category.id ? nil : category.id
                            },
                            onSubmenuSelect: { selectedSubcategory = $0 }
                        )
                    }
                }
                .padding()
                .onAppear(perform: loadCategories)
                                NavigationLink(
                    destination: PartnerList(selectedSubcategory: $selectedSubcategory),
                    isActive: Binding(
                        get: { selectedSubcategory != nil },
                        set: { newValue in
                            if !newValue {
                            }
                        }
                    )
                ) { EmptyView() }
            }
            .onDisappear {
                expandedMenuID = nil
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    private func loadCategories() {
        let db = Firestore.firestore()
        db.collection("Category").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching categories: \(error)")
                return
            }
            if let snapshot = snapshot {
                self.categories = snapshot.documents.compactMap { document in
                    let data = document.data()
                    let id = document.documentID
                    let category = data["Category"] as? String ?? ""
                    let categoryIcon = data["Category_Icon"] as? String ?? ""
                    let subCategory = data["SubCategory"] as? [String] ?? []
                    
                    return Category(id: id, category: category, categoryIcon: categoryIcon, subCategory: subCategory)
                }
            }
        }
    }
}

struct MenuView: View {
    let iconName: String
    let menuName: String
    let submenuItems: [SubmenuItem]
    let isExpanded: Bool
    let onToggle: () -> Void
    let onSubmenuSelect: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)

                Text(menuName)
                    .font(.custom("Poppins-SemiBold", size: 15))
                    .foregroundColor(Color("MainColor2"))
                Spacer()
                Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                    .padding(.trailing, 8)
                    .foregroundColor(Color("MainColor3"))
            }
            .padding()
            .onTapGesture {
                onToggle()
            }
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(submenuItems) { submenu in
                        HStack {
                            Image(submenu.name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 22)

                            Text(submenu.name)
                                .font(.custom("Poppins-SemiBold", size: 16))
                                .foregroundColor(Color("MainColor2"))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color("MainColor3"))
                                .padding(.trailing, 10)
                        }
                        .padding(.leading, 25)
                        .onTapGesture {
                            onSubmenuSelect(submenu.name)
                        }
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 10)
                }
                .padding(.bottom, 10)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("MainColor2"), lineWidth: 0.1)
        )
    }
}

struct SubmenuItem: Identifiable {
    let id = UUID()
    let iconName: String
    let name: String
}

#Preview {
    MainService()
}

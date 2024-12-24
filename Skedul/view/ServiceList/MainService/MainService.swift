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
//                
//                NavigationLink(
//                    destination: PartnerList(selectedSubcategory: $selectedSubcategory),
//                    isActive: Binding(
//                        get: { selectedSubcategory != nil },
//                        set: { newValue in
//                            if !newValue {
//                                selectedSubcategory = nil
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
//#Preview {
//    MainService()
//}

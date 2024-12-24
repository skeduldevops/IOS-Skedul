import SwiftUI
import Firebase
import FirebaseFirestore

struct FaqList: View {
    @State private var faqs: [FaqItem] = []
    @State private var expandedFaq: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(faqs) { faq in
                    FaqRow(faq: faq, isExpanded: expandedFaq == faq.id) {
                        expandedFaq = expandedFaq == faq.id ? nil : faq.id
                    }
                    .padding(.bottom, 8)
                    
                    Divider()
                        .background(Color("MainColor3"))
                }
            }
            .padding()
        }
        .onAppear {
            fetchFaqs()
        }
    }

    func fetchFaqs() {
        let db = Firestore.firestore()
        db.collection("Faq").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching FAQs: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found.")
                return
            }

            self.faqs = documents.map { doc in
                FaqItem(
                    id: doc.documentID,
                    title: doc["Title"] as? String ?? "No Title",
                    body: doc["Body"] as? String ?? "No Body"
                )
            }
        }
    }
}

struct FaqRow: View {
    let faq: FaqItem
    let isExpanded: Bool
    let toggleExpanded: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(alignment: .center) {
                Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                    .foregroundColor(Color("MainColor2"))
                
                Spacer().frame(width: 10)
                
                Text(faq.title)
                    .font(Font.custom("Poppins-Medium", size: 16))
                    .foregroundColor(Color("MainColor2"))
                    .multilineTextAlignment(.leading)

                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                toggleExpanded()
            }

            if isExpanded {
                Text(faq.body)
                    .font(Font.custom("Poppins-Regular", size: 14))
                    .foregroundColor(Color("MainColor3"))
                    .padding(.leading, 24)
            }
        }
        .padding(.vertical, 5)
    }
}

struct FaqItem: Identifiable {
    let id: String
    let title: String
    let body: String
}

#Preview {
    FaqList()
}

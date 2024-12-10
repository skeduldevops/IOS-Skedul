import Foundation

struct Partner: Identifiable, Decodable {
    var id: String
    var partnerName: String
    var partnerEmail: String
    var businessName: String
    var address: String?
    var phone: String?
    var typeCategory: String?
    var typeSubcategory: String?
    var created: String?
    var statusApproval: String?
    var image: String?
    var npwp: String?
    var nib: String?
    var totalReview: String?
    var filterRating: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case partnerName = "partner_name"
        case partnerEmail = "partner_email"
        case businessName = "business_name"
        case address = "adress"
        case phone
        case typeCategory = "type_category"
        case typeSubcategory = "type_subcategory"
        case created
        case statusApproval = "status_approval"
        case image
        case npwp
        case nib
        case totalReview = "total_review"
        case filterRating = "filter_rating"
    }
}

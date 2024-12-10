//
//  CurrentUser.swift
//  Skedul
//
//  Created by skedul on 05/11/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct CurrentUser{
    
    var uid: String
    var email: String?
    var fullname: String?
    var username: String?
    var createdAt: String?
    var profileImageUrl: String?
    var profileImage: UIImage?
    var phone: String?
    var date_of_birth: String?
    var created_at: String?
    var confirm_18: Bool?
    var agreed_term_policy: Bool?
}

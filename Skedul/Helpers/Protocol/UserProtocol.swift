//
//  UserProtocol.swift
//  Skedul
//
//  Created by skedul on 05/11/24.
//
/*
import Foundation
import UIKit

protocol UserProtocol {
    var fullname: String? { get }
    var email: String? { get }
    var phone: String? { get }
    var confirm_18: Bool? { get }
    var agreed_term_policy: Bool? { get }
    var uid: String { get }
    var username: String? { get }
    var createdAt: String? { get }
    var profileImageUrl: String? { get }
    var profileImage: UIImage? { get }
    var date_of_birth: String? { get }
}

struct MockUser: UserProtocol {
    var uid: String = "12313asasda"
    var fullname: String? = "Kevin Labuno"
    var email: String? = "kevinlabuno@gmail.com"
    var phone: String? = "08213123213213"
    var username: String? = "kevinlabuno"
    var createdAt: String? = "2024-11-05"
    var profileImageUrl: String? = "http://example.com/image.jpg"
    var profileImage: UIImage? = nil
    var date_of_birth: String? = "1990-01-01"
    var confirm_18: Bool? = true
    var agreed_term_policy: Bool? = true
}

class MockUserManager: UserManager {
    override var currentUser: CurrentUser? {
        get {
            return MockUser(uid: "12313asasda")
        }
        set {
        }
    }
    
    override init() {
        super.init()
    }
}
*/

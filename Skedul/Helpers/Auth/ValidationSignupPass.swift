//
//  ValidationSignupPass.swift
//  Skedul
//
//  Created by skedul on 31/10/24.
//

import Foundation
import FirebaseAuth

struct ValidationSignupPass {
    
    static func validatePassword(_ password: String) -> String? {
        if !isPasswordValid(password) {
            return "Password must contain at least 8 characters, 1 uppercase letter, and 1 number."
        }
        return nil
    }
    
    static func validateConfirmPassword(password: String, confirmPassword: String) -> String? {
        if password != confirmPassword {
            return "Passwords do not match."
        }
        return nil
    }
    
    static func validateAge(isAgeConfirmed: Bool) -> String? {
        return isAgeConfirmed ? nil : "You must confirm that you are 18 years or older."
    }
    
    static func validatePolicy(isAgreedToPolicy: Bool) -> String? {
        return isAgreedToPolicy ? nil : "You must agree with the privacy policy & terms of use."
    }
    
    private static func isPasswordValid(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9]).{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
}

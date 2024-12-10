//
//  ValidationSignup.swift
//  Skedul
//
//  Created by skedul on 31/10/24.
//

import Foundation

extension String {
    var containsWhitespace: Bool {
        return self.rangeOfCharacter(from: .whitespaces) != nil
    }
}

struct ValidationSignup {
    
    static func validateFields(fullname: String, email: String, username: String, phone: String, dateOfBirth: Date) -> (isValid: Bool, alertMessage: String?) {
        if fullname.isEmpty {
            return (false, "Full Name must be filled.")
        }
        
        if email.isEmpty || !isValidEmail(email) {
            return (false, "Please enter a valid email address.")
        }
        
        if username.isEmpty || username.containsWhitespace {
            return (false, "Username must be filled and cannot contain spaces.")
        }
        
        if phone.isEmpty || !isValidPhone(phone) {
            return (false, "Phone Number must be filled with digits.")
        }
        
        if !isValidDateOfBirth(dateOfBirth) {
            return (false, "You must be at least 18 years old.")
        }
        
        return (true, nil)
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func isValidPhone(_ phone: String) -> Bool {
        return phone.allSatisfy { $0.isNumber }
    }
    
    static func isValidDateOfBirth(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let eighteenYearsAgo = calendar.date(byAdding: .year, value: -18, to: Date())!
        return date <= eighteenYearsAgo
    }
    
}

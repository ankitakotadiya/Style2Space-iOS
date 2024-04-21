//
//  ValidateData.swift
//  SignupLogin
//
//  Created by Ankita Kotadiya on 29/07/23.
//

import Foundation
import UIKit

enum EmailError: Error {
    case invalid
}

enum NameError: Error {
    case empty
    case invalid
}

enum PasswordError: Error {
    case empty
    case weak
    case validPassword
}

protocol ValidationProtocol: AnyObject {
    func validateEmail(_ email: String) -> Result<String, EmailError>
    func validatePassword(_ password: String) -> Result<String, PasswordError>
    func validatePhone(_ phone: String) -> Result<String, PasswordError>
    func validName(_ name: String) -> Result<String, NameError>
}

protocol handleErrorsProtocol: AnyObject {
    
    func handlePasswordError(_ error: PasswordError, vc: UIViewController)
    func handleEmailError(_ error: EmailError, vc: UIViewController)
    func handlePhoneError(_ error: PasswordError, vc: UIViewController)
    func handleNameError(_ error: NameError, vc: UIViewController)
}

class ValidateData: ValidationProtocol {
    
    private var message = ""
    
    func validName(_ name: String) -> Result<String, NameError> {
        
        if name.isEmpty {
            return .failure(.empty)
        }
        
        if !isValidName(name) {
            return .failure(.invalid)
        }
        
        return .success(name)
    }
    
    func validatePhone(_ phone: String) -> Result<String, PasswordError> {
        
        if phone.isEmpty {
            return .failure(.empty)
        }
        
        if phone.count < 10 {
            return .failure(.weak)
        }
        
        if !isValidPhoneNumberFormat(phone) {
            return .failure(.validPassword)
        }
        
        return .success(phone)
    }
    
    func validatePassword(_ password: String) -> Result<String, PasswordError> {
        
        if password.isEmpty {
            return .failure(.empty)
        }
        
        if password.count < 6{
            return .failure(.weak)
        }
        
        if !isValidPassword(password: password) {
            return .failure(.validPassword)
        }
        
        return .success(password)
    }
    
    func validateEmail(_ email: String) -> Result<String, EmailError> {
        
        if !isValidEmailFormat(email) {
            return .failure(.invalid)
        }
        
        return .success(email)
    }
    
    private func isValidEmailFormat(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidPhoneNumberFormat(_ phoneNumber: String) -> Bool {
        let phoneRegex = #"^\d{10}$"#
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phoneNumber)
    }
    
    private func isValidName(_ name: String) -> Bool {
        guard name.count >= 2 && name.count <= 50 else { return false }
        
        // Check character set (only letters and optional spaces)
        let characterSet = CharacterSet.letters.union(CharacterSet.whitespaces)
        guard name.rangeOfCharacter(from: characterSet.inverted) == nil else { return false }
        
        return true
    }
    
    private func isValidPassword(password: String) -> Bool {
        return true
    }
}

extension ValidateData: handleErrorsProtocol {
    func handleNameError(_ error: NameError, vc: UIViewController) {
        
        switch error {
        case .empty:
            message = "Please enter your full name."
            
        case .invalid:
            message = "Please enter a name"
        }
        
        vc.showAlert(title: "Full Name", message: message)
    }
    
    func handlePhoneError(_ error: PasswordError, vc: UIViewController) {
        switch error {
        case .empty:
            message = "Please enter your contact number."
            
        case .weak:
            message = "Phone number should be 10 digits long."
            
        case .validPassword:
            message = "Please enter a valid 10-digit phone number."
        }
        
        vc.showAlert(title: "Contact Number", message: message)
    }
    
    func handlePasswordError(_ error: PasswordError, vc: UIViewController) {
        switch error {
        case .empty:
            message = "Please enter your email."
            
        case .weak:
            message = "Your password must have at least 6 characters."
            
        case .validPassword:
            message = "Please enter a valid password."
        }
        
        vc.showAlert(title: "Password", message: message)
    }
    
    func handleEmailError(_ error: EmailError, vc: UIViewController) {
        switch error {
            
        case .invalid:
            message = "Please enter a valid email address."
        }
        
        vc.showAlert(title: "Email", message: message)
    }
    
}

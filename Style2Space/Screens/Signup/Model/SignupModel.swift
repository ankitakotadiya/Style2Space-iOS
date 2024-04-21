//
//  SignupModel.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 19/04/24.
//

import Foundation
import Combine


enum RightViewType {
    case none
    case gender
    case date
}

enum Placeholder: String {
    case fullname = "Full Name*"
    case email = "Your Email"
    case contact = "Contact Number*"
    case dob = "Date of Birth"
    case gender = "Gender"
    case password = "Password"
    case signup = "Sign Up"
}


struct SignupTextFieldModel {
    var text: String
    var placeholder: Placeholder
    var rightViewType: RightViewType
    var isSecureTextEntry: Bool
    var value: String
}

struct SignupData {
    var fullName: String
    var email: String
    var phone: String
    var dob: String
    var password: String
    var gender: String
    
    init(fullName: String = "", email: String = "", phone: String = "", dob: String = "", password: String = "", gender: String = "") {
        self.fullName = fullName
        self.email = email
        self.phone = phone
        self.dob = dob
        self.password = password
        self.gender = gender
    }
}

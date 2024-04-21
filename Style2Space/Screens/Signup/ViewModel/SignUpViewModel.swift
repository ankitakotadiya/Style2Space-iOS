//
//  SignUpViewModel.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 18/04/24.
//

import Foundation

protocol SignupTextFieldProtocol {
    var textFieldData:[SignupTextFieldModel] {get set}
}

class SignUpViewModel: SignupTextFieldProtocol {
    
    var textFieldData: [SignupTextFieldModel] = [
        SignupTextFieldModel(text: "", placeholder: .fullname, rightViewType: .none, isSecureTextEntry: false, value: ""),
        SignupTextFieldModel(text: "", placeholder: .email, rightViewType: .none, isSecureTextEntry: false, value: ""),
        SignupTextFieldModel(text: "", placeholder: .contact, rightViewType: .none, isSecureTextEntry: false, value: ""),
        SignupTextFieldModel(text: "", placeholder: .password, rightViewType: .none, isSecureTextEntry: true, value: ""),
        SignupTextFieldModel(text: "", placeholder: .dob, rightViewType: .date, isSecureTextEntry: false, value: ""),
        SignupTextFieldModel(text: "", placeholder: .gender, rightViewType: .gender, isSecureTextEntry: false, value: ""),
        SignupTextFieldModel(text: "Signup", placeholder: .signup, rightViewType: .none, isSecureTextEntry: false, value: "")]
    
    
    var params: [String:Any] = [:]
    var signupData: SignupData = SignupData()
    
    init(dictionary: [String:Any]) {
        self.params = dictionary
    }
    
    func SignUpButtonPressed() {
        
    }
}

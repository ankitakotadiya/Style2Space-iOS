//
//  CreatePasswordViewModel.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 18/04/24.
//

import Foundation

class CreatePasswordViewModel: LoginDataSourceProtocol {
    
    func forgotPasswordButtonTitles() -> (forgotPassword: String, reset: String) {
        return ("","")
    }
    
    var titleLabel: String {
        return "Create New Password"
    }
    
    var descriptionLabel: String {
        return "Now, you can create a new password and Confirm it below."
    }
    
    var emailPlaceHolder: String {
        return "New Password"
    }
    
    var passwordPlaceHolder: String {
        return "Confirm Password"
    }
    
    func SubmitPasswordButtonClicked(password: String) {
        
    }
    
}

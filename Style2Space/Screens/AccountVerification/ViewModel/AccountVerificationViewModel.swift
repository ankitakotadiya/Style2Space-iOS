//
//  AccountVerificationViewModel.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 18/04/24.
//

import Foundation

enum AccountType: String {
    case verification = "Account Verification"
    case forgotpassword = "Forgot Password"
}

protocol AccountVerificationViewModelProtocol: AnyObject {
    var viewType: AccountType {get set}
    func resendButtonTitles() -> (code: String, resend: String)
    var subtitle: String {get}

}

class AccountVerificationViewModel: AccountVerificationViewModelProtocol {
    
    var viewType: AccountType
    
    init(viewType: AccountType) {
        self.viewType = viewType
    }
    
    var subtitle: String {
        if viewType == .verification {
            return "Please type One Time Password (OTP) that we’ve sent to +91 98765 43210."
        }
        
        return "Please type One Time Password (OTP) that we’ve sent to your registered email & contact number."
    }
    
    func resendButtonTitles() -> (code: String, resend: String) {
        return ("Didn't receive yet? ", "Resend in 30s")
    }
    
}

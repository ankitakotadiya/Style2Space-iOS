//
//  OTPTextField.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 21/04/24.
//

import Foundation
import UIKit

class OTPTextField: UITextField {
    
    weak var previousTextField: OTPTextField?
    weak var nextTextField: OTPTextField?
    
    override public func deleteBackward(){
        text = ""
        previousTextField?.becomeFirstResponder()
    }
    
}

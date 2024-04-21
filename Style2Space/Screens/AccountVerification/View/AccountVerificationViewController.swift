//
//  AccountVerificationViewController.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 18/04/24.
//

import UIKit

class AccountVerificationViewController: UIViewController, Storyboard {
    
    // Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var passTextField1: OTPTextField!
    @IBOutlet weak var passTextField2: OTPTextField!
    @IBOutlet weak var passTextField3: OTPTextField!
    @IBOutlet weak var passTextField4: OTPTextField!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var resendButton: UIButton!
    
    private var textFieldsCollection: [OTPTextField] = []
    var remainingStrStack: [String] = []
    var accountViewModel: AccountVerificationViewModel? = nil
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextfields()
        setupTitles()
    }
    
    func setupTitles() {
        
        self.titleLabel.configure(text: accountViewModel?.viewType.rawValue, textColor: Colors.AppColour, font: UIFont.boldSystemFont(ofSize: 25.0), backgroundColor: UIColor.white, numberOfLines: 0, alignment: .left)
        
        self.descriptionLabel.configure(text: accountViewModel?.subtitle, textColor: UIColor.black, font: UIFont.systemFont(ofSize: 14.0), backgroundColor: UIColor.white, numberOfLines: 0, alignment: .left)
        
        if accountViewModel?.viewType == .verification {
            self.submitButton.setImage(UIImage(named: "submit-btn"), for: .normal)
        } else {
            self.submitButton.setImage(UIImage(named: "next-btn"), for: .normal)
        }
        
        let (code,resend) = accountViewModel?.resendButtonTitles() ?? ("","")
        let attributeString = CommonFunctions.setAttrubiteTitle(string1: code, string2: resend)
        self.resendButton.setAttributedTitle(attributeString, for: .normal)
    }
    
    func setupTextfields() {
        
        textFieldsCollection.append(passTextField1)
        textFieldsCollection.append(passTextField2)
        textFieldsCollection.append(passTextField3)
        textFieldsCollection.append(passTextField4)
        
        for (index,textfield) in textFieldsCollection.enumerated() {
            textfield.delegate = self
            textfield.textContentType = .oneTimeCode
            textfield.keyboardType = .numberPad
            textfield.placeholder = "*"
            //Adding a marker to previous field
            index != 0 ? (textfield.previousTextField = textFieldsCollection[index-1]) : (textfield.previousTextField = nil)
            //Adding a marker to next field for the field at index-1
            index != 0 ? (textFieldsCollection[index-1].nextTextField = textfield) : ()
        }
        
        self.textFieldsCollection[0].becomeFirstResponder()
    }
    
    private final func autoFillTextField(with string: String) {
        remainingStrStack = string.reversed().compactMap{String($0)}
        for textField in textFieldsCollection {
            if let charToAdd = remainingStrStack.popLast() {
                textField.text = String(charToAdd)
            } else {
                break
            }
        }
        //        checkForValidity()
        remainingStrStack = []
    }
    
    final func getOTP() -> String {
        var OTP = ""
        for textField in textFieldsCollection{
            OTP += textField.text ?? ""
        }
        OTP = OTP.trimmingCharacters(in: CharacterSet.whitespaces)
        return OTP
    }
    
    //checks if all the OTPfields are filled
    private final func checkForValidity(){
        for fields in textFieldsCollection{
            if (fields.text?.trimmingCharacters(in: CharacterSet.whitespaces) == ""){
                self.showAlert(title: "OTP", message: "Please enter valid code.")
                return
            }
        }
    }
    
    @IBAction func disTapSubmitButton(_ sender: UIButton) {
        let OTP = self.getOTP()
        
        if OTP.isEmpty {
            self.showAlert(title: "OTP", message: "Please enter otp.")
        } else if OTP.count < 4 || OTP.count > 4 {
            self.showAlert(title: "OTP", message: "Please enter valid 4-digit otp.")
        } else {
            self.coordinator?.PushtoNewPassword()
        }
    }
    
    @IBAction func didTapResendButton(_ sender: UIButton) {
        self.showAlert(title: "OTP", message: "One Time Password (OTP) that we’ve sent to your registered email & contact number.")
    }
}

extension AccountVerificationViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        checkForValidity()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let textfield = textField as? OTPTextField else { return true }
        
        if string.count > 1 {
            textfield.resignFirstResponder()
            autoFillTextField(with: string)
            return false
        } else {
            if (range.length == 0){
                if textfield.nextTextField == nil {
                    textfield.text? = string
                    textfield.resignFirstResponder()
                }else{
                    textfield.text? = string
                    textfield.nextTextField?.becomeFirstResponder()
                }
                return false
            }
            return true
        }
    }
}

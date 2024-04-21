//
//  CreatePasswordViewController.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 18/04/24.
//

import UIKit

class CreatePasswordViewController: UIViewController, Storyboard {
    
    // Outlets
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var confirmpasswordTextField: UITextField!
    @IBOutlet weak var newpasswordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    private var eyebutton1: UIButton?
    private var eyebutton2: UIButton?
    weak var coordinator: MainCoordinator?
    private let createPasswordViewModel: CreatePasswordViewModel = CreatePasswordViewModel()
    private let validationData: ValidateData = ValidateData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    func setupUI() {
        self.titleLable.configure(text: createPasswordViewModel.titleLabel, textColor: Colors.AppColour, font: UIFont.boldSystemFont(ofSize: 25.0), backgroundColor: UIColor.white, numberOfLines: 0, alignment: .left)
        
        self.descriptionLabel.configure(text: createPasswordViewModel.descriptionLabel, textColor: UIColor.black, font: UIFont.systemFont(ofSize: 14.0), backgroundColor: UIColor.white, numberOfLines: 0, alignment: .left)
        
        self.submitButton.setImage(UIImage(named: "submit-btn"), for: .normal)
        
        self.confirmpasswordTextField.configure(placeholder: createPasswordViewModel.emailPlaceHolder, textColor: UIColor.black, font: UIFont.systemFont(ofSize: 15.0), borderColor: UIColor.lightGray)
        self.confirmpasswordTextField.isSecureTextEntry = true
        
        self.newpasswordTextField.configure(placeholder: createPasswordViewModel.emailPlaceHolder, textColor: UIColor.black, font: UIFont.systemFont(ofSize: 15.0), borderColor: UIColor.lightGray)
        self.newpasswordTextField.isSecureTextEntry = true
        
        self.setupEyeButton()
    }
    
    func setupEyeButton() {
        
        self.eyebutton1 = self.confirmpasswordTextField.addEyeButtonToRightView(image: UIImage(named: "eye-close")!, target: self, action: #selector(togglePasswordVisibility(_:)))
        
        self.eyebutton2 = self.newpasswordTextField.addEyeButtonToRightView(image: UIImage(named: "eye-close")!, target: self, action: #selector(togglePasswordVisibility))
    }
    
    
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        
        if sender == self.eyebutton1 {
            self.confirmpasswordTextField.isSecureTextEntry.toggle()
            let imageName = confirmpasswordTextField.isSecureTextEntry ? "eye-close" : "eye-open"
            self.eyebutton1?.setImage(UIImage(named: imageName), for: .normal)
        } else {
            self.newpasswordTextField.isSecureTextEntry.toggle()
            let imageName = newpasswordTextField.isSecureTextEntry ? "eye-close" : "eye-open"
            self.eyebutton2?.setImage(UIImage(named: imageName), for: .normal)
        }
    }
    
    @IBAction func didTapSubmitButton(_ sender: UIButton) {
        
        let strText1: String = self.confirmpasswordTextField.text ?? ""
        let strText2: String = self.newpasswordTextField.text ?? ""
        
        var validPassword: String = ""
        
        let password = validationData.validatePassword(strText1)
        
        switch password{
        case .success(let validPass):
            validPassword = validPass
            
        case .failure(let passwordError):
            validationData.handlePasswordError(passwordError, vc: self)
            return
        }
        
        if strText1 != strText2 {
            self.showAlert(title: "New Password", message: "The new password and confirmation password do not match")
        } else {
            self.createPasswordViewModel.SubmitPasswordButtonClicked(password: validPassword)
        }
    }
}

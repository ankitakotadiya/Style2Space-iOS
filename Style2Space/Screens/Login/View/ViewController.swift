//
//  ViewController.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 15/04/24.
//

import UIKit
import Foundation


class ViewController: UIViewController, Storyboard {
    
    // Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    var eyeButton: UIButton?
    
    weak var coordinator: MainCoordinator?
    private let loginViewModel = LoginViewModel()
    private let validationModel = ValidateData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        self.navigationItem.backButtonTitle = ""
        
        self.titleLabel.configure(text: loginViewModel.titleLabel, textColor: Colors.AppColour, font: UIFont.boldSystemFont(ofSize: 25.0), backgroundColor: UIColor.white, numberOfLines: 0, alignment: .left)
        
        self.descriptionLabel.configure(text: loginViewModel.descriptionLabel, textColor: UIColor.black, font: UIFont.systemFont(ofSize: 14.0), backgroundColor: UIColor.white, numberOfLines: 0, alignment: .left)
        
        self.emailTextField.configure(placeholder: loginViewModel.emailPlaceHolder, textColor: UIColor.black, font: UIFont.systemFont(ofSize: 15.0), borderColor: UIColor.lightGray)

        self.passwordTextField.configure(placeholder: loginViewModel.passwordPlaceHolder, textColor: UIColor.black, font: UIFont.systemFont(ofSize: 15.0), borderColor: UIColor.lightGray)
        self.passwordTextField.isSecureTextEntry = true
        self.setupEyeButton()
        
        self.setForgotPasswordButtonTitle()
        
    }
    
    func setForgotPasswordButtonTitle() {
        let (forgotPassword, reset) = loginViewModel.forgotPasswordButtonTitles()
        let attributeString = CommonFunctions.setAttrubiteTitle(string1: forgotPassword, string2: reset)
        self.forgotPasswordButton.setAttributedTitle(attributeString, for: .normal)
    }
    
    func setupEyeButton() {
        
        self.eyeButton = self.passwordTextField.addEyeButtonToRightView(image: UIImage(named: "eye-close")!, target: self, action: #selector(togglePasswordVisibility))
    }
    
    
    @objc func togglePasswordVisibility() {
        self.passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye-close" : "eye-open"
        self.eyeButton?.setImage(UIImage(named: imageName), for: .normal)
    }
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        
        var strEmail = ""
        var strPassword = ""
        
        let email = validationModel.validateEmail(emailTextField.text ?? "")
        let password = validationModel.validatePassword(passwordTextField.text ?? "")
        
        switch email {
        case .success(let validEmail):
            strEmail = validEmail
            
        case .failure(let error):
            validationModel.handleEmailError(error, vc: self)
            return
        }
        
        switch password {
            
        case .success(let validPass):
            strPassword = validPass
            
        case .failure(let passwordError):
            validationModel.handlePasswordError(passwordError, vc: self)
            return
        }
        
        loginViewModel.callLoginAPI(email: strEmail, password: strPassword) { result in
            
            switch result {
                
            case .success(let loginModel):
                print("Navigate")
                
            case .failure(let error):
                self.showAlert(title: "Login", message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func didTapForgotPasswordButton(_ sender: UIButton) {
        self.coordinator?.PushtoForgotPassword()
    }
}


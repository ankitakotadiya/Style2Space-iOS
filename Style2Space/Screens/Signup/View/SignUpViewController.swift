//
//  SignUpViewController.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 18/04/24.
//

import UIKit

class SignUpViewController: UIViewController, Storyboard {
    
    private var signupViewModel: SignUpViewModel?
    private let validationModel = ValidateData()
    weak var coordinator: MainCoordinator?
    // Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var signupTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = ""
        self.signupViewModel = SignUpViewModel(dictionary: [:])
        self.setupUI()
        self.registerTableViewCell()
    }
    
    func setupUI() {
        self.titleLabel.configure(text: "Let’s Setup your account", textColor: Colors.AppColour, font: UIFont.boldSystemFont(ofSize: 25.0), backgroundColor: UIColor.white, numberOfLines: 0, alignment: .left)
        
        self.descriptionLabel.configure(text: "Please type full information below and confirm it below.", textColor: UIColor.black, font: UIFont.systemFont(ofSize: 14.0), backgroundColor: UIColor.white, numberOfLines: 0, alignment: .left)
    }
    
    func registerTableViewCell() {
        
        self.signupTableView.register(UINib(nibName: String.className(for: InputDataTableViewCell.self), bundle: nil), forCellReuseIdentifier: String.className(for: InputDataTableViewCell.self))
        
        self.signupTableView.register(UINib(nibName: String.className(for: SignupTableViewCell.self), bundle: nil), forCellReuseIdentifier: String.className(for: SignupTableViewCell.self))
        
        self.signupTableView.register(UINib(nibName: String.className(for: GenderDobTableViewCell.self), bundle: nil), forCellReuseIdentifier: String.className(for: GenderDobTableViewCell.self))
        
        self.signupTableView.register(UINib(nibName: String.className(for: SignupTableViewCell.self), bundle: nil), forCellReuseIdentifier: String.className(for: SignupTableViewCell.self))
        self.signupTableView.dataSource = self
        self.signupTableView.delegate = self
        
    }
}

extension SignUpViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return signupViewModel?.textFieldData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if signupViewModel?.textFieldData[indexPath.row].placeholder == .signup {
            
            if let signupcell = tableView.dequeueReusableCell(withIdentifier: String.className(for: SignupTableViewCell.self)) as? SignupTableViewCell {
                signupcell.delegate = self
                signupcell.configureView()
                return signupcell
            }
        } else if signupViewModel?.textFieldData[indexPath.row].placeholder == .gender || signupViewModel?.textFieldData[indexPath.row].placeholder == .dob {
            
            if let popupcell = tableView.dequeueReusableCell(withIdentifier: String.className(for: GenderDobTableViewCell.self)) as? GenderDobTableViewCell {
                if let data = signupViewModel?.textFieldData[indexPath.row] {
                    popupcell.delegate = self
                    popupcell.configure(for: data)
                }
                return popupcell
            }
        } else if let textFieldCell = tableView.dequeueReusableCell(withIdentifier: String.className(for: InputDataTableViewCell.self), for: indexPath) as? InputDataTableViewCell {
            
            if let data = signupViewModel?.textFieldData[indexPath.row] {
                textFieldCell.commonTextField.delegate = self
                textFieldCell.configureCell(for: data)
            }
            return textFieldCell
        }
        
        return UITableViewCell()
    }
}

extension SignUpViewController: UITableViewDelegate, GenderDobTableViewCellDelegate, SignupTableViewCellDelegate {
    
    func didTapLoginButton() {
        self.coordinator?.PushtoLogin()
    }
    
    func didTapSignupButton() {
        
        var strName = ""
        var strEmail = ""
        var strContact = ""
        var strPassword = ""
        
        let name = validationModel.validName(self.getInputValue(for: Placeholder.fullname))
        let email = validationModel.validateEmail(self.getInputValue(for: Placeholder.email))
        let phone = validationModel.validatePhone(self.getInputValue(for: Placeholder.contact))
        let password = validationModel.validatePassword(self.getInputValue(for: Placeholder.password))
        
        switch name {
        case .success(let validName):
            strName = validName
            
        case .failure(let nameError):
            self.validationModel.handleNameError(nameError, vc: self)
//            return
        }
        
        switch email {
        case .success(let validEmail):
            strEmail = validEmail
            
        case .failure(let error):
            validationModel.handleEmailError(error, vc: self)
//            return
        }
        
        switch phone {
        case .success(let validPhone):
            strContact = validPhone
            
        case .failure(let error):
            validationModel.handlePhoneError(error, vc: self)
//            return
        }
        
        switch password {
        case .success(let validPass):
            strPassword = validPass
            
        case .failure(let passwordError):
            validationModel.handlePasswordError(passwordError, vc: self)
//            return
        }
        
        let params: [String:Any] = ["name": strName, "email": strEmail, "phone": strContact, "password": strPassword]
        self.signupViewModel = SignUpViewModel(dictionary: params)
        signupViewModel?.SignUpButtonPressed()
        self.coordinator?.PushtoAccountVerification()
    }
    
    private func getInputValue(for placeHolder: Placeholder) -> String {
        
        var inpVal = ""
        if let index = signupViewModel?.textFieldData.firstIndex(where: { $0.placeholder == placeHolder}) {
            inpVal = signupViewModel?.textFieldData[index].value ?? ""
        }
        
        return inpVal
    }
    
    func didSelectDatePicker(in cell: GenderDobTableViewCell, sourceView: UIButton) {
        
        self.view.resignFirstResponder()
        
        lazy var datePicker: UIDatePicker = {
            let picker = UIDatePicker()
            picker.datePickerMode = .date
            picker.preferredDatePickerStyle = .inline
            picker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
            return picker
        }()
        
        self.presentViewAsPopover(datePicker, sourceView: sourceView, sourceRect: sourceView.bounds, permittedArrowDirections: .down, popoverdelegate: self)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        let strDate = dateFormatter.mediumDateString(from: sender.date)
        
        self.updateTextFieldData(for: Placeholder.dob, newValue: strDate)
    }
    
    func didSelectGender(in cell: GenderDobTableViewCell, sourceView: UIButton) {
        
        self.view.resignFirstResponder()

        let maleAction = UIAlertAction(title: "Male", style: .default) { action in
            cell.onselectGender = "Male"
            self.updateTextFieldData(for: Placeholder.gender, newValue: "Male")
        }
        
        let femaleAction = UIAlertAction(title: "Female", style: .default) { action in
            cell.onselectGender = "Female"
            self.updateTextFieldData(for: Placeholder.gender, newValue: "Female")
        }
        
        self.presentActionSheet(title: "Gender", message: "Please Select Gender", actions: [maleAction, femaleAction])
    }
}

extension SignUpViewController : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        self.signupTableView.reloadData()
        return true
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func updateTextFieldData(for placeholder: Placeholder, newValue: String) {
        if let index = signupViewModel?.textFieldData.firstIndex(where: { $0.placeholder == placeholder}) {
            signupViewModel?.textFieldData[index].value = newValue
            self.signupTableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .none)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let placeHolder = Placeholder(rawValue: textField.placeholder ?? "") {
            self.updateTextFieldData(for: placeHolder, newValue: textField.text ?? "")
        }
    }
}




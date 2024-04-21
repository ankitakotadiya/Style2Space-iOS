//
//  InputDataTableViewCell.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 18/04/24.
//

import UIKit


class InputDataTableViewCell: UITableViewCell {

    @IBOutlet weak var commonTextField: UITextField!
    
    private var dategenderButton: UIButton?
    private var signupData: SignupData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(for data: SignupTextFieldModel) {
        
        commonTextField.isSecureTextEntry = data.isSecureTextEntry
        commonTextField.text = data.value
        commonTextField.placeholder = data.placeholder.rawValue
        
        if data.placeholder == .email {
            commonTextField.keyboardType = .emailAddress
        } else if data.placeholder == .contact {
            commonTextField.keyboardType = .decimalPad
        } else {
            commonTextField.keyboardType = .default
        }
        
    }
    
}


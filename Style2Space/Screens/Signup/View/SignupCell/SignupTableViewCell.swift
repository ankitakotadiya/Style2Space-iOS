//
//  SignupTableViewCell.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 18/04/24.
//

import UIKit

protocol SignupTableViewCellDelegate: AnyObject {
    func didTapSignupButton()
    func didTapLoginButton()
}

class SignupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var termsandconditionButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    weak var delegate: SignupTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureView() {
        self.signupButton.setImage(UIImage(named: "signup"), for: .normal)
        self.signupButton.addTarget(self, action: #selector(SignupButtonClicked(_:)), for: .touchUpInside)
        self.termsandconditionButton.setTitleColor(Colors.LightGray, for: .normal)
        self.termsandconditionButton.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        
        self.loginButton.setAttributedTitle(CommonFunctions.setAttrubiteTitle(string1: "Already have an account? ", string2: "Login"), for: .normal)
        self.loginButton.addTarget(self, action: #selector(LoginButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func SignupButtonClicked(_ sender: UIButton) {
        self.delegate?.didTapSignupButton()
    }
    
    @objc func LoginButtonClicked(_ sender: UIButton) {
        self.delegate?.didTapLoginButton()
    }
    
}

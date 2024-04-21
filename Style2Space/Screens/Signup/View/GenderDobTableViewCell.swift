//
//  GenderDobTableViewCell.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 20/04/24.
//

import UIKit

protocol GenderDobTableViewCellDelegate: AnyObject {
    func didSelectDatePicker(in cell: GenderDobTableViewCell, sourceView: UIButton)
    func didSelectGender(in cell: GenderDobTableViewCell, sourceView: UIButton)
}

class GenderDobTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popupButton: UIButton!
    
    weak var delegate: GenderDobTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configureLabel(lbl: self.titleLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    var onselectGender: String = "" {
        didSet {
            self.titleLabel.textColor = UIColor.black
            self.titleLabel.text = "  \(onselectGender)"
        }
    }
    
    func configure(for data: SignupTextFieldModel) {
        
        self.titleLabel.text = data.value.count > 0 ? "  \(data.value)" : "  \(data.placeholder.rawValue)"
        self.titleLabel.textColor = data.value.count > 0 ? UIColor.black : Colors.borderColor

        if data.placeholder == .dob {
            self.popupButton.setImage(UIImage(named: "calender"), for: .normal)
            self.popupButton.addTarget(self, action: #selector(setupDatePicker(_:)), for: .touchUpInside)
        } else if data.placeholder == .gender {
            self.popupButton.setImage(UIImage(named: "drop-down"), for: .normal)
            self.popupButton.addTarget(self, action: #selector(displayGenderAlert(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func setupDatePicker(_ sender: UIButton) {
        self.delegate?.didSelectDatePicker(in: self, sourceView: sender)
    }
    
    @objc private func displayGenderAlert(_ sender: UIButton) {
        self.delegate?.didSelectGender(in: self, sourceView: sender)
    }
    
    func configureLabel(lbl: UILabel) {
        lbl.textColor = Colors.borderColor
        lbl.font = UIFont.systemFont(ofSize: 14.0)
        lbl.layer.cornerRadius = 5.0
        lbl.layer.borderWidth = 0.5
        lbl.layer.borderColor = Colors.borderColor.cgColor
    }
    
}

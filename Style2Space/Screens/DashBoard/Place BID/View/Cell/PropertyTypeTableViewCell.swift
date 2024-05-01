//
//  PropertyTypeTableViewCell.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 28/04/24.
//

import UIKit

protocol PlaceBidCellConfigureProtocol: AnyObject {
    func configure(for data: PlaceBiDRows)
}

protocol PropertyTypeButtonClickedDelegate: AnyObject {
    func downArrowClicked(cell: PropertyTypeTableViewCell)
}

class PropertyTypeTableViewCell: UITableViewCell, Reusable, PlaceBidCellConfigureProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    private var data: PlaceBiDRows?
    private var arrowButton: UIButton?
    weak var delegate: PropertyTypeButtonClickedDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(for data: PlaceBiDRows) {
        self.data = data
        
        self.titleLabel.configure(text: self.data?.title.rawValue, textColor: Colors.AppColour, font: UIFont.systemFont(ofSize: 14.0), backgroundColor: .clear, numberOfLines: 0, alignment: .left)
        
        self.textField.configure(placeholder: self.data?.placeHolder.rawValue, textColor: Colors.AppColour, font: UIFont.systemFont(ofSize: 15.0), borderColor: .lightGray)
        
        if self.data?.title == .projectType {
            self.arrowButton = self.textField.addEyeButtonToRightView(image: UIImage(named: "down-arrow")!, target: self, action: #selector(didTapArrowButton))
        } else {
            self.textField.rightView = nil
        }
    }
    
    @objc func didTapArrowButton() {
        self.delegate?.downArrowClicked(cell: self)
    }
}

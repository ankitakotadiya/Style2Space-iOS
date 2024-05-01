//
//  WorkAreaTableViewCell.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 28/04/24.
//

import UIKit

class WorkAreaTableViewCell: UITableViewCell, Reusable, PlaceBidCellConfigureProtocol{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var dropDownButton: UIButton!
    
    private var data: PlaceBiDRows?

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
        
        self.textField.configure(
            placeholder: self.data?.placeHolder.rawValue,
            textColor: Colors.AppColour,
            font: UIFont.systemFont(ofSize: 15.0),
            borderColor: .lightGray
        )
        
        self.titleLabel.configure(
            text: self.data?.title.rawValue,
            textColor: Colors.AppColour,
            font: UIFont.systemFont(ofSize: 14.0),
            backgroundColor: .clear,
            numberOfLines: 0,
            alignment: .left)
        
        if let options = self.data?.propertyOptionsName {
            for propertyOption in options {
                if propertyOption == .sqft {
                    if data.PropertyOptionsSelected.contains(propertyOption) {
                        self.dropDownButton.setUpButton(
                            text: propertyOption.rawValue,
                            textColor: .white,
                            font: UIFont.systemFont(ofSize: 15.0),
                            cornerRadius: self.dropDownButton.frame.height/2,
                            borderWidth: 1.0,
                            borderColor: Colors.AppColour,
                            backgroundColor: Colors.AppColour)
                    } else {
                        self.dropDownButton.setUpButton(
                            text: propertyOption.rawValue,
                            textColor: Colors.LightGray,
                            font: UIFont.systemFont(ofSize: 15.0),
                            cornerRadius: self.dropDownButton.frame.height/2,
                            borderWidth: 1.0,
                            borderColor: Colors.LightGray,
                            backgroundColor: .white)
                    }
                }
            }
        }
    }
}

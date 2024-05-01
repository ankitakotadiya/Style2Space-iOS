//
//  PlaceBidTableViewCell.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 28/04/24.
//

import UIKit

class PlaceBidButtonTableViewCell: UITableViewCell, Reusable, PlaceBidCellConfigureProtocol {
    @IBOutlet weak var termsandCondition: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
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
        self.termsandCondition.setUpButton(
            text: self.data?.placeHolder.rawValue ?? "",
            textColor: Colors.LightGray,
            font: UIFont.systemFont(ofSize: 10.0, weight: .thin),
            cornerRadius: 0.0,
            borderWidth: 0.0)
    }
}

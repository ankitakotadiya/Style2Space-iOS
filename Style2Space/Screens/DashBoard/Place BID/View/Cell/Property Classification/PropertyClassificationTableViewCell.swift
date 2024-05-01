//
//  PropertyClassificationTableViewCell.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 28/04/24.
//

import UIKit
import Combine

enum PropertyClassificationCellEvent {
    case buttonDidChange(rowType: RowType, selected: PropertyOptions)
}


class PropertyClassificationTableViewCell: UITableViewCell, Reusable, PlaceBidCellConfigureProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var topstack1Button: UIButton!
    @IBOutlet weak var topstack2Button: UIButton!
    @IBOutlet weak var bottomstack1Button: UIButton!
    @IBOutlet weak var bottomstack2Button: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    private var data: PlaceBiDRows?
    private let eventSubject = PassthroughSubject<PropertyClassificationCellEvent, Never>()
    var eventPublisher: AnyPublisher<PropertyClassificationCellEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
    var cancellables = Set<AnyCancellable>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.topstack1Button.addTarget(self, action: #selector(button1Tapped(_:)), for: .touchUpInside)
        self.topstack2Button.addTarget(self, action: #selector(button2Tapped(_:)), for: .touchUpInside)

        // Initialization code
    }
    
    override func prepareForReuse() {
      super.prepareForReuse()
      cancellables = Set<AnyCancellable>()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(for data: PlaceBiDRows) {
        self.data = data
        
        titleLabel.configure(
            text: data.title.rawValue,
            textColor: Colors.AppColour,
            font: UIFont.systemFont(ofSize: 14.0),
            backgroundColor: .clear,
            numberOfLines: 0,
            alignment: .left
        )
        textField.isHidden = data.title != .details
        if self.data?.title == .details {
            textField.configure(
                placeholder: data.placeHolder.rawValue,
                textColor: Colors.AppColour,
                font: UIFont.systemFont(ofSize: 15.0),
                borderColor: .lightGray
            )
        }
        
        let buttonConfigs: [(UIButton, PropertyOptions, PropertyOptions)] = [
            (topstack1Button, .residential, .worktype),
            (topstack2Button, .corporate, .renovation),
            (bottomstack1Button, .studio, .kitchen),
            (bottomstack2Button, .hotel, .living)
        ]
        
        var title = ""
        for (button, option1, option2) in buttonConfigs {
            if data.propertyOptionsName.contains(option1) || data.propertyOptionsName.contains(option2) {
                let option = data.propertyOptionsName.contains(option1) ? option1 : option2
                title = option.rawValue
                button.setTitle(option.rawValue, for: .normal)
            } else {
                button.setTitle(nil, for: .normal)
            }
            
            // Configure button appearance based on selected options
            if data.PropertyOptionsSelected.contains(option1) || data.PropertyOptionsSelected.contains(option2) {
                button.setUpButton(text: title, textColor: .white, font: UIFont.systemFont(ofSize: 15.0), cornerRadius: button.frame.height/2, borderWidth: 1.0, borderColor: Colors.AppColour, backgroundColor: Colors.AppColour)
            } else {
                button.setUpButton(text: title, textColor: Colors.LightGray, font: UIFont.systemFont(ofSize: 15.0), cornerRadius: button.frame.height/2, borderWidth: 1.0, borderColor: Colors.LightGray, backgroundColor: UIColor.white)
            }
        }
    }
    
    @objc func button1Tapped(_ sender: UIButton) {
        
        var propertyOption: PropertyOptions?
        
        if let title = self.data?.title {
            if title == .classification {
                propertyOption = (sender.backgroundColor == Colors.AppColour) ? PropertyOptions.none : .residential
            } else {
                propertyOption = .worktype
            }
            eventSubject.send(.buttonDidChange(rowType: title, selected: propertyOption!))
        }
    }
    
    @objc func button2Tapped(_ sender: UIButton) {
        
        var propertyOption: PropertyOptions?
        
        if let title = self.data?.title {
            if title == .classification {
                propertyOption = (sender.backgroundColor == Colors.AppColour) ? PropertyOptions.none : .corporate
            } else {
                propertyOption = .renovation
            }
            
            eventSubject.send(.buttonDidChange(rowType: title, selected: propertyOption!))
        }
    }
}

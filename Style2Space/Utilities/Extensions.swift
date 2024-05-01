//
//  Extensions.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 18/04/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func presentViewAsPopover(_ subView: UIView, sourceView: UIView, sourceRect: CGRect, permittedArrowDirections: UIPopoverArrowDirection, popoverdelegate: UIPopoverPresentationControllerDelegate) {
        // Create a view controller to hold the date picker
        let datePickerViewController = UIViewController()
        datePickerViewController.view.backgroundColor = .white // Set background color
        
        datePickerViewController.view.addSubview(subView)
        
        // Set the modal presentation style to popover
        datePickerViewController.modalPresentationStyle = .popover
        
        // Configure the popover presentation controller
        if let popoverPresentationController = datePickerViewController.popoverPresentationController {
            popoverPresentationController.sourceView = sourceView
            popoverPresentationController.sourceRect = sourceRect
            popoverPresentationController.permittedArrowDirections = permittedArrowDirections
            popoverPresentationController.delegate = popoverdelegate
        }
        
        // Present the date picker view controller
        DispatchQueue.main.async {
            self.present(datePickerViewController, animated: true, completion: nil)
        }
    }
    
    func presentAlertWithCustomSubview(_ subview: UIView, sourceView: UIView, sourceRect: CGRect, permittedArrowDirections: UIPopoverArrowDirection, preferredStyle: UIAlertController.Style, popoverdelegate: UIPopoverPresentationControllerDelegate? = nil) {
        // Create an UIAlertController with the specified style
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: preferredStyle)
        
        // Add the custom subview to the alert controller's view
        alertController.view.addSubview(subview)
        alertController.modalPresentationStyle = .popover
        // Present the alert controller
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = sourceView
            popoverController.sourceRect = sourceRect
            popoverController.permittedArrowDirections = [permittedArrowDirections]
            popoverController.delegate = popoverdelegate
        }
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func presentActionSheet(title: String?, message: String?, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        // Add user-defined actions
        for action in actions {
            alertController.addAction(action)
        }
        
        // Add cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Present the action sheet
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat, fram: CGRect) {
        let maskPath = UIBezierPath(
            roundedRect: frame,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.frame = fram
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) where T: Reusable {
        register(T.nib, forCellReuseIdentifier: String.className(for: cellType))
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type) where T: Reusable {
        register(T.nib, forCellWithReuseIdentifier: String.className(for: cellType))
    }
}

extension UINavigationController {
    
    func setupNavigationAppearance() {
        
        let backButtonImage = UIImage(named: "back")
        self.navigationBar.backIndicatorImage = backButtonImage
        self.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        self.navigationBar.tintColor = .black
                
        // Set navigation bar title text attributes
//        self.navigationBar.titleTextAttributes = [
//            NSAttributedString.Key.foregroundColor: UIColor.black,
//            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)
//        ]
        self.navigationBar.prefersLargeTitles = false
        
        // Set navigation bar style
        self.navigationBar.barStyle = .default
        self.navigationBar.isTranslucent = true
        
    }
    
}

extension String {    
    func toData(using encoding: String.Encoding = .utf8) -> Data {
        return data(using: encoding)!
    }
}

extension DateFormatter {
    /// - Returns: A string representation of the date using the medium date style.
    func mediumDateString(from date: Date) -> String {
        self.dateStyle = .medium
        return self.string(from: date)
    }
}

extension UITextField {
    
    func configure(placeholder: String?, textColor: UIColor?, font: UIFont?, backgroundColor: UIColor? = nil, borderColor: UIColor?, borderWidth: CGFloat? = nil, cornerRadius: CGFloat? = nil) {
        self.placeholder = placeholder
        self.textColor = textColor
        self.font = font
        self.backgroundColor = backgroundColor
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = borderWidth ?? 0
        self.layer.cornerRadius = cornerRadius ?? 0
    }
    
    func addEyeButtonToRightView(image: UIImage, target: Any?, action: Selector) -> UIButton {
        // Lazily create the containerView
        lazy var containerView: UIView = {
            let padding: CGFloat = 8
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 30 + padding, height: 30))
            return view
        }()
        
        // Lazily create the eye button
        lazy var eyeButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setImage(image, for: .normal)
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            button.addTarget(target, action: action, for: .touchUpInside)
            button.imageView?.contentMode = .scaleAspectFill
            button.clipsToBounds = true
            return button
        }()
        
        // Add the eye button to the containerView
        containerView.addSubview(eyeButton)
        
        // Assign the containerView to the right view of the text field
        self.rightView = containerView
        self.rightViewMode = .always
        
        return eyeButton
    }
}

extension UIButton {
    func setUpButton(text: String,
                     textColor: UIColor,
                     font: UIFont,
                     alignment: NSTextAlignment = .left,
                     image: UIImage? = nil,
                     cornerRadius: CGFloat,
                     borderWidth: CGFloat,
                     borderColor: UIColor? = nil,
                     backgroundColor: UIColor = .white) {
        
        // Set button title properties
        self.setTitle(text, for: .normal)
//        self.titleLabel?.textColor = textColor
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = font
        self.titleLabel?.textAlignment = alignment
        // Set button image
        self.setImage(image, for: .normal)
        
        // Set button appearance properties
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
        self.backgroundColor = backgroundColor
    }
}

extension UILabel {
    
    func configure(text: String? = nil, textColor: UIColor? = nil, font: UIFont? = nil, backgroundColor: UIColor? = nil, numberOfLines: Int = 1, alignment: NSTextAlignment = .left) {
        self.text = text
        self.textColor = textColor
        self.font = font
        self.backgroundColor = backgroundColor
        self.numberOfLines = numberOfLines
        self.textAlignment = alignment
    }
}



//
//  Constants.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 17/04/24.
//

import UIKit

    
struct Colors {
    static let AppColour = UIColor(red: 149/255.0, green: 58/255.0, blue: 33/255.0, alpha: 1.0)
    static let LightGray = UIColor(red: 159/255.0, green: 159/255.0, blue: 159/255.0, alpha: 1.0)
    static let borderColor = UIColor(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0)
}

struct APIHeaders {
    
    static func defaultHeaders() -> [String: String] {
        return ["Authorization": "Bearer your_token"]
    }
}


struct APIs {
    static let baseURL = ""
}

enum Endpoint: String {
    case login = ""
    
}

struct CommonFunctions {
    static func setAttrubiteTitle(string1: String, string2: String) -> NSMutableAttributedString {
        
        let forgotPasswordAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14) // Adjust the font size as needed
        ]
        let forgotPasswordAttributedString = NSAttributedString(string: string1, attributes: forgotPasswordAttributes)
        
        let resetAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors.AppColour,
            .font: UIFont.boldSystemFont(ofSize: 14) // Adjust the font size as needed
        ]
        let resetAttributedString = NSAttributedString(string: string2, attributes: resetAttributes)
        
        let combinedString = NSMutableAttributedString()
        combinedString.append(forgotPasswordAttributedString)
        combinedString.append(resetAttributedString)
        
        return combinedString
    }
}





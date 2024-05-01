//
//  PlaceBidModel.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 28/04/24.
//

import Foundation


struct PlaceBidModel {
    let rows: [PlaceBiDRows]
}

struct PlaceBiDRows {
    var title: RowType
    var placeHolder: PropertyPlaceholder
    var textfieldTitle: String
    var propertyOptionsName: [PropertyOptions]
    var PropertyOptionsSelected: Set<PropertyOptions>
    
    static var collection: [PlaceBiDRows] =
    [PlaceBiDRows(title: .name, placeHolder: .name, textfieldTitle: "", propertyOptionsName: [.none], PropertyOptionsSelected: Set(arrayLiteral: .none)),
     PlaceBiDRows(title: .classification, placeHolder: .none, textfieldTitle: "", propertyOptionsName: [.residential, .corporate, .studio, .hotel], PropertyOptionsSelected: Set(arrayLiteral: .residential)),
     PlaceBiDRows(title: .type, placeHolder: .type, textfieldTitle: "", propertyOptionsName: [.none], PropertyOptionsSelected: Set(arrayLiteral: .none)),
     PlaceBiDRows(title: .details, placeHolder: .bedroom, textfieldTitle: "", propertyOptionsName: [.worktype, .renovation, .kitchen, .living], PropertyOptionsSelected: Set(arrayLiteral: .renovation,.living)),
     PlaceBiDRows(title: .projectType, placeHolder: .projectType, textfieldTitle: "", propertyOptionsName: [.none], PropertyOptionsSelected: Set(arrayLiteral: .none)),
     PlaceBiDRows(title: .workarea, placeHolder: .area, textfieldTitle: "", propertyOptionsName: [.sqft], PropertyOptionsSelected:Set(arrayLiteral: .sqft)),
     PlaceBiDRows(title: .budget, placeHolder: .budget, textfieldTitle: "", propertyOptionsName: [.none], PropertyOptionsSelected: Set(arrayLiteral: .none)),
     PlaceBiDRows(title: .submit, placeHolder: .terms, textfieldTitle: "", propertyOptionsName: [.none], PropertyOptionsSelected: Set(arrayLiteral: .none))]
}

enum PropertyPlaceholder: String {
    case name = "Your Property Name"
    case type = "Flat / Villa / Independent House"
    case bedroom = "No. of Bedroom"
    case projectType = "Select Any"
    case area = "Property Work Area"
    case budget = "₹  Amount in Lakhs"
    case terms = "By submitting this BID, you agree that the provided information is accurate. Final scope and pricing are subject to further agreement. Use of this service is governed by our Terms and Privacy Policy."
    case none = "none"
}

enum RowType: String {
    case name = "Property Name"
    case classification = "Property Classification"
    case type = "Property Type"
    case details = "Work Details"
    case projectType = "Project Type"
    case workarea = "Work Area"
    case budget = "Estimated Budget"
    case submit = "Submit"
}

enum PropertyOptions: String {
    case residential = "Residential"
    case corporate = "Corporate / Office"
    case studio = "Studio"
    case hotel = "Hotel/Cafe"
    case worktype = "New Work"
    case renovation = "Renovation"
    case kitchen = "Kitchen"
    case living = "Living Room"
    case sqft = "Sq. Ft."
    case none = "none"
}

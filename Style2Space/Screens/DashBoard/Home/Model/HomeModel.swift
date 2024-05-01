//
//  HomeModel.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 24/04/24.
//

import Foundation

struct HomeModel {
    
}

enum ButtonTitles: String {
    case placebid = "Bid"
    case portfolio = "Portfolio"
    case ideas = "Ideas"
    case clintinterior = "Interior"
    case insight = "Insight"
    case none = "none"
}

enum HomeSections: String {
    case first = "first"
    case second = "second"
    case third = "third"
}


struct TableViewSection {
    let title: HomeSections
    let rows: [TableRows]
}

struct SectionHeader {
    let title: String
    let subTitle: String
}

struct TableRows {
    var title: String
    var description: String
    var buttonTiles: ButtonTitles
    let header: SectionHeader
}

struct ImageModel {
    var title: String
    var image: String
}

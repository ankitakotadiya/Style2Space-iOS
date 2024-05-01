//
//  TabBarModel.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 23/04/24.
//

import Foundation

struct TabBarModel {
    
    let imageName: ImageName
    let selecteImage: SelectedImage
    let title: String
    
}

enum ImageName: String {
    case home = "home"
    case search = "search"
    case bid = "bid"
    case favourite = "favourite"
    case settings = "settings"
    
}

enum SelectedImage: String {
    case homeSelected = "home-selected"
    case searchSelected = "search-selected"
    case favouriteSelected = "favourite-selected"
    case settingsSelected = "settings-selected"
    case bidSelected = "bid-selected"
}

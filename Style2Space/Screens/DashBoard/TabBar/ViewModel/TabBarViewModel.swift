//
//  TabBarViewModel.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 23/04/24.
//

import Foundation

protocol TabBarViewModelProtocol {
    var tabItems: [TabBarModel] {get}
}

struct TabBarViewModel: TabBarViewModelProtocol {
    
    var tabItems: [TabBarModel] {
        return [TabBarModel(imageName: .home, selecteImage: .homeSelected, title: ""),
                TabBarModel(imageName: .search, selecteImage: .searchSelected, title: ""),
                TabBarModel(imageName: .bid, selecteImage: .bidSelected, title: ""),
                TabBarModel(imageName: .favourite, selecteImage: .favouriteSelected, title: ""),
                TabBarModel(imageName: .settings, selecteImage: .settingsSelected, title: "")
        ]
    }
    
}

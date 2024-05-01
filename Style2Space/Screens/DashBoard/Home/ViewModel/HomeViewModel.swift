//
//  HomeViewModel.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 24/04/24.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    var rowsSections: [TableViewSection] {get}
    var imageModel: [ImageModel] {get}
}

class HomeViewModel: HomeViewModelProtocol {
    var imageModel: [ImageModel] {
        return [ImageModel(title: "", image: "home-dummy"),
                ImageModel(title: "", image: "home-dummy"),
                ImageModel(title: "", image: "home-dummy"),
                ImageModel(title: "", image: "home-dummy"),
                ImageModel(title: "", image: "home-dummy")]
    }
    
    var rowsSections: [TableViewSection] {
        return [TableViewSection(title: .first, rows:
            [TableRows(title: "Discover your ideal vision, connect with interior designers, & give your space a stunning new look.", description: "The interior so good, Where style meets space.", buttonTiles: .placebid, header: SectionHeader(title: "", subTitle: "")),
             TableRows(title: "A Glimpse into an Interior Designer's Portfolio", description: "", buttonTiles: .portfolio, header: SectionHeader(title: "", subTitle: "")),
            TableRows(title:"Discover a curated selection of Design Ideas", description: "", buttonTiles: .ideas, header: SectionHeader(title: "", subTitle: ""))]),
        TableViewSection(title: .second, rows:
            [TableRows(title: "Discover a glimpse of our Clients' Interiors", description: "", buttonTiles: .clintinterior, header: SectionHeader(title: "Stay in the loop with the latest trends in Interior Designs!", subTitle: "Discover a wide range of design solutions and expert tips on the Style2Space Journal Section."))]),
        TableViewSection(title: .third, rows:
            [TableRows(title: "Quick, Informative, & Relevant analysis at fingertips.", description: "", buttonTiles: .insight, header: SectionHeader(title: "Instant Insights", subTitle: ""))])]
    }
}

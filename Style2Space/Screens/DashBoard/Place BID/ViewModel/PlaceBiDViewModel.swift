//
//  PlaceBiDViewModel.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 28/04/24.
//

import Foundation
import Combine

protocol PlaceBidViewModelProtocol {
    var tableData: [PlaceBiDRows] {get}
}
class PlaceBiDViewModel: PlaceBidViewModelProtocol {
    @Published var tableData: [PlaceBiDRows] = PlaceBiDRows.collection
        
}

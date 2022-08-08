//
//  EarthquakeCellDataModel.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 8/8/22.
//

import Foundation

//Cell Data Model contains 2 parts
//viewModel: view model that provides data for redering view
//actionModel: actions that need inside of cell
protocol EarthquakeCellDataModel {
    
    var viewModel: EarthquakeCollectionViewCellViewModel {set get}
    
    var actionModel: EarthquakeCellActions {set get}
    
}

struct EarthquakeListCollectionViewCellDataModel: EarthquakeCellDataModel {
    
    var viewModel: EarthquakeCollectionViewCellViewModel
    
    var actionModel: EarthquakeCellActions
}

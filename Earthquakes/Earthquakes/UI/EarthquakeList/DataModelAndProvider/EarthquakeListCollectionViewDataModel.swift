//
//  EarthquakeListCollectionViewDataModel.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 8/2/22.
//

import Foundation

/// Data Provider for Earthquake Collection View
protocol EarthquakeCollectionViewDataModelProvider {
    
    var dataProvider: EarthquakesListRemoteDataProvider { get }
    
    var dataModels: [EarthquakeCellDataModel] {get}
    
}

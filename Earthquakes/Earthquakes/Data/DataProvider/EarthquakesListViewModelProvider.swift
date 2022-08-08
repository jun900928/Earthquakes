//
//  ViewModelProvider.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 8/8/22.
//

import Foundation

protocol EarthquakesListViewModelProvider {
    
    func getMetaData() -> EarthquakesResponseMetaData?
    
    func getFeatures() -> [EarthquakesFeature]?
    
    func getTitle() -> String?
}

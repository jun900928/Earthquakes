//
//  EarthquakeCellActions.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 8/8/22.
//

import Foundation

//actions data that will be execute in cell
protocol EarthquakeCellActions {
    
    var rightButtonAction: () -> Void { get }
    
    var didSelectItem:() -> Void { get }
}


struct EarthquakeListCollectionViewCellActions :EarthquakeCellActions {
    
    var rightButtonAction: () -> Void
    
    var didSelectItem:() -> Void
    
}

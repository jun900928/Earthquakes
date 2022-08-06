//
//  EarthquakeListCollectionViewDataModel.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 8/2/22.
//

import Foundation

protocol EarthquakeDataModelProvider {
    var dataProvider: RemoteDataProvider { get }
    var dataModels: [EarthquakeCellDataModel] {get}
}

protocol EarthquakeCellDataModel {
    var viewModel: EarthquakeCollectionViewCellViewModel {set get}
    var actionModel: EarthquakeCellActions {set get}
}

protocol EarthquakeCellActions {
    var rightButtonAction: () -> Void { get }
    var didSelectItem:() -> Void { get }
}

protocol EarthquakeCollectionViewCellViewModel {
    var imageName: String? { get }
    var title: String? { get }
    var subtile: String? { get }
    var detail: String? { get }
    var leftBottom: String? { get }
    var rightButtonTitle: String? { get }
}

struct EarthquakeFeatureModel: EarthquakeCellDataModel {
    var viewModel: EarthquakeCollectionViewCellViewModel
    var actionModel: EarthquakeCellActions
}

struct EarthquakeListCollectionViewCellActions :EarthquakeCellActions {
    var rightButtonAction: () -> Void
    var didSelectItem:() -> Void
}

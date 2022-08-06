//
//  EarthquakeCollectionViewDataModelProvider.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 8/3/22.
//

import UIKit
class EarthquakeCollectionViewDataModelProvider  {
    let remoteDataProvider: EarthquakesListRemoteDataProvider
    weak var coordinator: EarthquakeListCoordinator?
    private var features: [EarthquakesFeature]?

    init(_ remoteDataProvider: EarthquakesListRemoteDataProvider, coordinator: EarthquakeListCoordinator?) {
        self.remoteDataProvider = remoteDataProvider
        self.coordinator = coordinator
    }
    
    func buildCellDataModels() -> [EarthquakeCellDataModel]{
        var dataModels = [EarthquakeCellDataModel]()
        let fatures = dataProvider.getFeatures()
        fatures?.forEach({ feature in
            let actionModel = EarthquakeListCollectionViewCellActions.init {[weak self] in
                guard let self = self else { return }
                self.openWebView(urlStr: feature.properties.url)
            } didSelectItem: { [weak self] in
                guard let self = self else { return }
                self.openWebView(urlStr: feature.properties.url)
            }
            let dataModel = EarthquakeFeatureModel.init(viewModel: feature, actionModel: actionModel)
            dataModels.append(dataModel)
        })
        return dataModels
    }
    
    private func openWebView(urlStr: String?) {
        guard let coordinator = coordinator else { return }
        coordinator.openDetailWebview(urlStr: urlStr)
    }
}

extension EarthquakeCollectionViewDataModelProvider: EarthquakeDataModelProvider{
    var dataProvider: RemoteDataProvider {
        return self.remoteDataProvider
    }
    
    var dataModels: [EarthquakeCellDataModel] {
        return self.buildCellDataModels()
    }
}

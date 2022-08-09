//
//  EarthquakeListCollectionViewDataModelProvider.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 8/3/22.
//

import UIKit
class EarthquakeListCollectionViewDataModelProvider  {
    let remoteDataProvider: EarthquakesListViewModelRemoteDataProvider
    weak var coordinator: EarthquakeListCoordinator?

    init(_ remoteDataProvider: EarthquakesListViewModelRemoteDataProvider, coordinator: EarthquakeListCoordinator?) {
        self.remoteDataProvider = remoteDataProvider
        self.coordinator = coordinator
    }
    
    private func openWebView(urlStr: String?) {
        guard let coordinator = coordinator else { return }
        coordinator.openDetailView(urlStr: urlStr)
    }
}

extension EarthquakeListCollectionViewDataModelProvider: EarthquakeCollectionViewDataModelProvider{
    var dataProvider: EarthquakesListRemoteDataProvider {
        return self.remoteDataProvider
    }
    
    var dataModels: [EarthquakeCellDataModel] {
        return self.buildCellDataModels()
    }
    
    private func buildCellDataModels() -> [EarthquakeCellDataModel]{
        var dataModels = [EarthquakeCellDataModel]()
        let fatures = remoteDataProvider.getFeatures()
        fatures?.forEach({ feature in
            let actionModel = EarthquakeListCollectionViewCellActions.init {[weak self] in
                guard let self = self else { return }
                self.openWebView(urlStr: feature.properties.url)
            } didSelectItem: { [weak self] in
                guard let self = self else { return }
                self.openWebView(urlStr: feature.properties.url)
            }
            let dataModel = EarthquakeListCollectionViewCellDataModel.init(viewModel: feature, actionModel: actionModel)
            dataModels.append(dataModel)
        })
        return dataModels
    }
}

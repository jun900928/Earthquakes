//
//  EarthquakeListViewControllerDataSource.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import UIKit

protocol DataUpdatable {
    func updateDataModels()
}

class EarthquakeListViewControllerDataSource: NSObject{
    
    let dataModelProvider: EarthquakeCollectionViewDataModelProvider
    
    private var dataModels: [EarthquakeCellDataModel] = []
    
    init(_ dataModelProvider: EarthquakeCollectionViewDataModelProvider) {
        self.dataModelProvider = dataModelProvider
    }
}

extension EarthquakeListViewControllerDataSource: DataUpdatable {
    func updateDataModels() {
        dataModels = dataModelProvider.dataModels
    }
}
    
extension EarthquakeListViewControllerDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !dataModels.isEmpty {
            return dataModels.count + 1
        }else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == dataModels.count,
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RefreshCollectionViewCell.cellID,
                                                          for: indexPath) as? RefreshCollectionViewCell {
            return cell
        }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EarthquakeCollectionViewCell.cellID,
                                                         for: indexPath) as? EarthquakeCollectionViewCell {
            cell.dataModel = dataModels[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
}



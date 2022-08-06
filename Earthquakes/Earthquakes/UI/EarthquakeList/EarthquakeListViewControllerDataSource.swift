//
//  EarthquakeListViewControllerDataSource.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import UIKit

class EarthquakeListViewControllerDataSource: NSObject {
    
    let dataModelProvider: EarthquakeDataModelProvider
    //copy of data in case reponse change in the middle
    var copyDataModels: [EarthquakeCellDataModel] = []
    
    init(_ dataModelProvider: EarthquakeDataModelProvider) {
        self.dataModelProvider = dataModelProvider
    }
}
    
extension EarthquakeListViewControllerDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        copyDataModels = dataModelProvider.dataModels
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !copyDataModels.isEmpty {
            return copyDataModels.count + 1
        }else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == copyDataModels.count,
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RefreshCollectionViewCell.cellID,
                                                          for: indexPath) as? RefreshCollectionViewCell {
            return cell
        }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EarthquakeCollectionViewCell.cellID,
                                                         for: indexPath) as? EarthquakeCollectionViewCell {
            cell.dataModel = copyDataModels[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
}



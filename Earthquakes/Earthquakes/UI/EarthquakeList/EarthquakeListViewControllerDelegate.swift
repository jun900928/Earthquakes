//
//  EarthquakeListViewControllerDelegate.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import UIKit

class EarthquakeListCollectionViewDelegateFlowLayout: NSObject {
    
    let dataModelProvider: EarthquakeCollectionViewDataModelProvider
    
    let coordinator: EarthquakeListCoordinatorHandler?
    
    init(_ dataModelProvider: EarthquakeCollectionViewDataModelProvider,
         coordinator: EarthquakeListCoordinatorHandler?) {
        self.dataModelProvider = dataModelProvider
        self.coordinator = coordinator
    }
}
 
extension EarthquakeListCollectionViewDelegateFlowLayout: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row <= dataModelProvider.dataModels.count else { return }
        dataModelProvider.dataModels[indexPath.row].actionModel.didSelectItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        Task.init {
            if let cell = cell as? Refresher {
                cell.beginRefreshing()
                do {
                    let _ = try await dataModelProvider.dataProvider.requestNextPageRemoteData()
                    if let dataSource = collectionView.dataSource as? DataUpdatable {
                        dataSource.updateDataModels()
                        collectionView.reloadData()
                    }
                }catch let error {
                    self.coordinator?.errorHandling(error, on: collectionView.superview)
                }
                cell.endRefreshing()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let collectionViewLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize.zero}
        guard indexPath.row <= dataModelProvider.dataModels.count else { return CGSize.zero}
        
        let referenceWidth = referenceWidth(collectionView, layout: collectionViewLayout)
        if indexPath.row < dataModelProvider.dataModels.count {
            let sizingCell = EarthquakeCollectionViewCell()
            sizingCell.dataModel = dataModelProvider.dataModels[indexPath.row]
            let referenceHeight = sizingCell.calculateHieght(width: referenceWidth)
            return CGSize(width: referenceWidth, height: referenceHeight)
        } else {
            let sizingCell = RefreshCollectionViewCell()
            return CGSize(width: referenceWidth, height: sizingCell.calculateHieght(width: referenceWidth))
        }
    }
    
    //Calculate the horizontal insets base on its content
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        guard let collectionViewLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return UIEdgeInsets.zero }
        
        let referenceWidth = referenceWidth(collectionView, layout: collectionViewLayout)
                
        let numberOfCells = floor(collectionView.safeAreaLayoutGuide.layoutFrame.size.width / referenceWidth)
        let edgeInsets = (collectionView.frame.size.width - (numberOfCells * referenceWidth)) / (numberOfCells + 1)
        
        return UIEdgeInsets(top: .zero, left: edgeInsets, bottom: .zero, right: edgeInsets)
    }
    
    private func referenceWidth(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout) -> CGFloat {
        let maxWidth = 300.0
        let sectionInset = collectionViewLayout.sectionInset
        
        let width = collectionView.safeAreaLayoutGuide.layoutFrame.width
            - sectionInset.left
            - sectionInset.right
            - collectionView.contentInset.left
            - collectionView.contentInset.right
        return min(maxWidth, width)
    }
}

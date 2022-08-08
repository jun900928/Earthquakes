//
//  EarthquakeCollectionViewCellViewModel.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 8/1/22.
//

import Foundation

/// view model for rendering EarthquakeCollectionViewCell UI
protocol EarthquakeCollectionViewCellViewModel {
    
    var imageName: String? { get }
    
    var title: String? { get }
    
    var subtile: String? { get }
    
    var detail: String? { get }
    
    var leftBottom: String? { get }
    
    var rightButtonTitle: String? { get }
}

extension EarthquakesFeature: EarthquakeCollectionViewCellViewModel {
    
    var imageName: String? {
        return "ImageNotFound"
    }
    
    var title: String? {
        return properties.place
    }
    
    var subtile: String? {
        return properties.title
    }
    
    var detail: String? {
        return "Detail:\n" + properties.detail +
               "\nURL: \n" + (properties.url ?? "")
    }
    
    var leftBottom: String? {
        let updated = properties.updated
        let epochTime = TimeInterval(updated) / 1000
        let date = Date(timeIntervalSince1970: epochTime)
        return DateFormatter().formateDataOnCurrentTimeZone(date: date)
    }
    
    var rightButtonTitle: String? {
        return  "Status: " + (properties.status ?? "")
    }
    
    var rightButtonAction: () -> Void {
        return {}
    }
    
    var didSelectItemAt: () -> Void {
        return {}
    }
}




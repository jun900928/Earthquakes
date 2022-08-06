//
//  EarthquakeCollectionViewCellViewModel.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 8/1/22.
//

import Foundation
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




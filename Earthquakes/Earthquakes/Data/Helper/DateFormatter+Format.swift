//
//  DateFormatter+Format.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import Foundation

public extension DateFormatter {
    func formateData(date: Date) -> String {
        dateFormat = "yyyy-MM-dd"
        return self.string(from: date)
    }
    
    func formateDataOnCurrentTimeZone(date: Date) -> String {
        dateFormat = "yyyy-MM-dd HH:mm:ss"
        return self.string(from: date)
    }
}

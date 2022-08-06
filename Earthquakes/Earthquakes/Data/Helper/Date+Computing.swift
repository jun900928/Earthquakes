//
//  Date+Computing.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import Foundation

public extension Date {
    func last30Days() -> Date {
        let date = Date().addingTimeInterval(30 * 24 * 60 * 60 * -1)
        return date
    }
}

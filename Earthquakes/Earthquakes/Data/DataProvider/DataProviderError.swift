//
//  DataProviderError.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import Foundation

enum DataProviderError: Error {
    case parsingError
    case notImplemented
    
    var localizedDescription: String {
        switch self {
        case .parsingError: return "An error occured while parsing the JSON response"
        case .notImplemented: return "This call has not yet been implemented"
        }
    }
}

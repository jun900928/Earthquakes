//
//  NetworkError.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 8/5/22.
//

import Foundation
enum NetworkError: Error {
    case badURL, serverError, decodeFail, queryCondition
    
    var localizedDescription: String {
        switch self {
        case .badURL: return "An error occured with request url"
        case .serverError: return "An error occured while connecting server"
        case .decodeFail: return "An error occured while parsing the JSON response"
        case .queryCondition: return "An error occured while generate query condition"
        }
    }
}


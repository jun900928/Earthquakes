//
//  HTTPStatusCode.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 8/5/22.
//

import Foundation
enum HTTPStatusCode: Int {
    //2xx success
    case ok = 200
    
    //4xx client errors
    case notFound = 404
}

enum HTTPError: String, Error {
    case invalidResponse
    case invalidStatusCode
    case noData
}

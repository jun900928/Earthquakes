//
//  ServiceUrlBuilder.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import Foundation
enum QueryItemNames: String, CaseIterable {
    case format, offset, limit, starttime, endtime
}

class QueryServiceUrlBuilder {
    private static let host = "https://earthquake.usgs.gov"
    private static let path = "/fdsnws/event/1/query"
    
    // build the search URL base on query item
    //https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2014-01-01&endtime=2014-01-02&limit=10
    static func buildUrl(configuration: QueryConfig) -> URL?{
        var urlComponents = URLComponents(string: host)
        urlComponents?.path = path
        var queryItems = [URLQueryItem]()
        QueryItemNames.allCases.forEach({ name in
            let value = configuration.getQueryVaue(key: name)
            let queryItem = URLQueryItem(name: name.rawValue, value: value)
            queryItems.append(queryItem)
        })
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}

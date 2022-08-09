//
//  QueryRequest.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/31/22.
//

import Foundation

protocol Request {
    func requestUrl() -> URL?
}

struct QueryConfig {
    let format: String
    let offset: UInt
    let limit: UInt
    let starttime: String
    let endtime: String
    
    init(starttime: String,
         endtime: String,
         format: String = "geojson",
         offset: UInt = 1,
         limit: UInt = 20000) {
        self.starttime = starttime
        self.endtime = endtime
        self.format = format
        self.offset = offset
        self.limit = limit
    }
    
    func getQueryVaue(key: QueryItemNames) -> String {
        switch key {
        case .format:
            return format
        case .offset:
            return String(offset)
        case .limit:
            return String(limit)
        case .starttime:
            return starttime
        case .endtime:
            return endtime
        }
    }
}

struct QueryRequest: Request {
    let config: QueryConfig
    func requestUrl() -> URL? {
        return QueryServiceUrlBuilder.buildUrl(configuration: config)
    }
}

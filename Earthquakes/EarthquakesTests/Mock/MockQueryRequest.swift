//
//  MockQueryRequest.swift
//  EarthquakesTests
//
//  Created by Mingjun Lei on 8/9/22.
//

import Foundation
@testable import Earthquakes

class MockRequest: Request {
    func requestUrl() -> URL? {
        return URL.init(string: "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2014-01-01&endtime=2014-01-02&limit=10")
    }
}

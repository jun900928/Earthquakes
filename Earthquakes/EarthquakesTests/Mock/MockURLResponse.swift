//
//  MockURLResponse.swift
//  EarthquakesTests
//
//  Created by Mingjun Lei on 8/9/22.
//

import Foundation
@testable import Earthquakes

class MockURLResponse: HTTPURLResponse {
    
    init? (_ statusCode: HTTPStatusCode = .ok) {
        super.init(url: URL.init(string: "https://www.google.com")!,
                   statusCode: statusCode.rawValue,
                   httpVersion: nil,
                   headerFields: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

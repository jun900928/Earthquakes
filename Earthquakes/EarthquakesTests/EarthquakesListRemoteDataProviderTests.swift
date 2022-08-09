//
//  EarthquakesListRemoteDataProviderTests.swift
//  EarthquakesTests
//
//  Created by Mingjun Lei on 8/9/22.
//

import XCTest
@testable import Earthquakes

class EarthquakesListRemoteDataProviderTestTests: XCTestCase {

    func testRefreshRemoteData_Success() throws {
        let mockService = MockNetworkService.init(data: mockData)
        let remoteDataProvider = EarthquakesListViewModelRemoteDataProvider(mockService)
        let exp = expectation(description: "Loading URL")
        let config = QueryConfig.init(starttime: "2014-01-01", endtime: "2014-02-01")
        remoteDataProvider.refreshRemoteData(config: config) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response.features)
                XCTAssertTrue(response.features!.count == pagesize)
            case .failure(let error):
                XCTAssertTrue(false, error.localizedDescription)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    func testRefreshRemoteData_Empty() throws {
        let mockService = MockNetworkService.init(data: mockEmptyData)
        let remoteDataProvider = EarthquakesListViewModelRemoteDataProvider(mockService)
        let exp = expectation(description: "Loading URL")
        let config = QueryConfig.init(starttime: "2014-01-01", endtime: "2014-02-01")
        remoteDataProvider.refreshRemoteData(config: config) { result in
            switch result {
            case .success(let response):
                XCTAssertNil(response.features)
                XCTAssertNil(response.metadata)
                XCTAssertNil(response.type)
            case .failure(let error):
                XCTAssertTrue(false, error.localizedDescription)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    func testRefreshRemoteData_Invaild() throws {
        let mockService = MockNetworkService.init(data: mockInvaildData)
        let remoteDataProvider = EarthquakesListViewModelRemoteDataProvider(mockService)
        let exp = expectation(description: "Loading URL")
        let config = QueryConfig.init(starttime: "2014-01-01", endtime: "2014-02-01")
        remoteDataProvider.refreshRemoteData(config: config) { result in
            switch result {
            case .success(_):
                XCTAssertTrue(false)
            case .failure(let error):
                XCTAssertTrue(error as? NetworkError == NetworkError.decodeFail)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10)
    }

}

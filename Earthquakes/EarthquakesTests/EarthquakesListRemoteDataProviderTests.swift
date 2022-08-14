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
        Task.init {
            do {
                let response = try await remoteDataProvider.refreshRemoteData(config: config)
                XCTAssertNotNil(response.features)
                XCTAssertTrue(response.features!.count == pagesize)
            } catch let error {
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
        Task.init {
            do {
                let response = try await remoteDataProvider.refreshRemoteData(config: config)
                XCTAssertNil(response.features)
                XCTAssertNil(response.metadata)
                XCTAssertNil(response.type)
            } catch let error {
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
        Task.init {
            do {
                async let _ = try await remoteDataProvider.refreshRemoteData(config: config)
                XCTAssertTrue(false)
            } catch let error {
                XCTAssertTrue(error as? NetworkError == NetworkError.decodeFail)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10)
    }

}

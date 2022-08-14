//
//  RemoteDataProvider.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import Foundation

typealias EarthquakesResponseResult = Result<EarthquakesResponse, Error>

protocol EarthquakesListRemoteDataProvider {
    
    func refreshRemoteData(config: QueryConfig) async throws -> EarthquakesResponse
    
    func requestNextPageRemoteData() async throws -> EarthquakesResponse
}

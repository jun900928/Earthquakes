//
//  DataProvider.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import Foundation

protocol DataProvider {
    func getMetaData() -> EarthquakesResponseMetaData?
    func getFeatures() -> [EarthquakesFeature]?
    func getTitle() -> String?
}

typealias EarthquakesResponseResult = Result<EarthquakesResponse, Error>

protocol RemoteDataProvider: DataProvider {
    func refreshRemoteData(config: QueryConfig, completion: @escaping (EarthquakesResponseResult) -> Void)
    func requestNextPageRemoteData(completion: @escaping (EarthquakesResponseResult) -> Void)
}

//
//  EarthquakesListViewModelRemoteDataProvider.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import Foundation
import Combine

let pagesize: UInt = 10

class EarthquakesListViewModelRemoteDataProvider {
    
    var response: EarthquakesResponse?
    
    var config: QueryConfig?
    
    var isRefreshing = false
    
    let networkService: Service
    
    init(_ networkService: Service = NetworkService.instance) {
        self.networkService = networkService
    }
}

extension EarthquakesListViewModelRemoteDataProvider: EarthquakesListViewModelProvider {
    
    func getMetaData() -> EarthquakesResponseMetaData? {
        return response?.metadata
    }
    
    func getFeatures() -> [EarthquakesFeature]? {
        return response?.features
    }
    
    func getTitle() -> String? {
        return response?.metadata?.title
    }
}

extension EarthquakesListViewModelRemoteDataProvider: EarthquakesListRemoteDataProvider{
    ///make a new query to fetch the data base on now
    ///
    @MainActor
    func refreshRemoteData(config: QueryConfig) async throws -> EarthquakesResponse {
        return try await withCheckedThrowingContinuation { continuation in
            Task.init {
                do {
                    let response = try await requestRemoteData(config: config)
                    self.config = config
                    self.response = response
                    continuation.resume(with: .success(response))
                } catch let error {
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
    
    /// query for next page of data base on current QueryConfig
    @MainActor
    func requestNextPageRemoteData() async throws -> EarthquakesResponse {
        return try await withCheckedThrowingContinuation { continuation in
            Task.init {
                do {
                    guard isRefreshing == false else { throw "Some fetching is running"}
                    guard let config = config,
                          let limit = response?.metadata?.limit,
                          let count = response?.metadata?.count,
                          limit == count else {
                        throw NetworkError.queryCondition
                    }
                    
                    let nextConfig =  QueryConfig.init(starttime: config.starttime,
                                                       endtime: config.endtime,
                                                       offset: config.offset + pagesize,
                                                       limit: config.limit)
                    isRefreshing = true
                    let response = try await requestRemoteData(config: config)
                    self.isRefreshing = false
                    self.config = nextConfig
                    let mergedResponse = self.mergeEarthquakesResponse(newResponse: response)
                    self.response = mergedResponse
                    continuation.resume(with: .success(mergedResponse))
                }catch let error {
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
}
    
extension EarthquakesListViewModelRemoteDataProvider {
    
    /// Merge thee new response with current one,
    /// We can abstaract this pogic out to be a designated data manager and inject in
    /// - Parameter newResponse: new response  come in
    /// - Returns: merged responsed
    private func mergeEarthquakesResponse(newResponse: EarthquakesResponse) -> EarthquakesResponse{
        guard let oldFeatures = response?.features,
              let newFeatures = newResponse.features else {
            return newResponse
        }
        let res = EarthquakesResponse.init(type: newResponse.type,
                                           metadata: newResponse.metadata,
                                           features: oldFeatures + newFeatures)
        return res
    }
    
    // request remove data
    private func requestRemoteData(config: QueryConfig) async throws -> EarthquakesResponse {
        return try await withCheckedThrowingContinuation { continuation in
            let request = QueryRequest.init(config: config)
            networkService.queryResults(request: request)
            .subscribe(Subscribers.Sink.init(receiveCompletion: { completionResult in
                switch completionResult {
                case .finished:
                    break
                case .failure(let error):
                    continuation.resume(with: .failure(error))
                }
            }, receiveValue: { response in
                continuation.resume(with: .success(response))
            }))
        }
    }
}

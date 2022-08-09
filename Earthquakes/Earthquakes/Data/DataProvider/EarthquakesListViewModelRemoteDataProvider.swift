//
//  EarthquakesListViewModelRemoteDataProvider.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import Foundation

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
    func refreshRemoteData(config: QueryConfig, completion: @escaping (EarthquakesResponseResult) -> Void) {
        requestRemoteData(config: config) {[weak self]  result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.config = config
                self.response = response
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
       }
    }
    
    /// query for next page of data base on current QueryConfig
    func requestNextPageRemoteData(completion: @escaping (EarthquakesResponseResult) -> Void) {
        guard isRefreshing == false else {return}
        guard let config = config,
              let limit = response?.metadata?.limit,
              let count = response?.metadata?.count,
                limit == count else {
            completion(.failure(NetworkError.queryCondition))
            return
        }

        let nextConfig =  QueryConfig.init(starttime: config.starttime,
                                       endtime: config.endtime,
                                       offset: config.offset + pagesize,
                                       limit: config.limit)
        isRefreshing = true
        requestRemoteData(config: nextConfig) { [weak self] result in
            guard let self = self else { return }
            self.isRefreshing = false
            switch result {
            case .success(let response):
                self.config = nextConfig
                let mergedResponse = self.mergeEarthquakesResponse(newResponse: response)
                self.response = mergedResponse
                completion(.success(mergedResponse))
            case .failure(let error):
                completion(.failure(error))
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
    private func requestRemoteData(config: QueryConfig, completion: @escaping (EarthquakesResponseResult) -> Void) {
        let request = QueryRequest.init(config: config)
        self.networkService.queryResults(request: request) { (_ result: Result<EarthquakesResponse, Error>) in
            switch result {
            case .success(let resposne):
                completion(.success(resposne))
            case .failure(let error):
                completion(.failure(error))
                print(error)
            }
        }
    }
    
}

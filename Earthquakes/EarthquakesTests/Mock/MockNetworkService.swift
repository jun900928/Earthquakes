//
//  MockNetworkService.swift
//  EarthquakesTests
//
//  Created by Mingjun Lei on 8/9/22.
//

import Foundation
import Combine

@testable import Earthquakes

//Mock the service provider
class MockNetworkService: Service {
    
    private let decoder = JSONDecoder()
    private var cancellables = Set<AnyCancellable>()
    
    let data: Data?
    let response: HTTPURLResponse?
    let error: Error?
    
    init(data: Data? = nil, response: HTTPURLResponse? = MockURLResponse(.ok), error: Error? = nil) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    func queryResults<T: Decodable>(request: Request) -> Future<T, Error> {
        return Future<T, Error>{[weak self] promise in
            guard let _ = request.requestUrl(), let self = self else {
                return promise(.failure(NetworkError.badURL))
            }
            
            guard let response = self.response,
                    200...299 ~= response.statusCode else {
                return promise(.failure(HTTPError.invalidStatusCode))
            }
            
            self.data.publisher
                .tryMap({ data -> T in
                    guard let decodeData = try? self.decoder.decode(T.self, from: data) else {
                        throw NetworkError.decodeFail
                    }
                    return decodeData
                })
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completionStatus in
                    switch completionStatus{
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }, receiveValue: { response in
                    promise(.success(response))
                }).store(in: &self.cancellables)
        }
    }
}

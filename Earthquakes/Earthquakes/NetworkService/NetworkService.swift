//
//  NetworkService.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import Foundation
import Combine

fileprivate let timeoutIntervalForRequest = 5.0

class NetworkService: Service {
    static let instance = NetworkService()
    var dataTask: URLSessionDataTask?
    
    private let defaultSession: URLSession
    private let queue = DispatchQueue.global()
    private let decoder = JSONDecoder()

    private init() {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = timeoutIntervalForRequest
        sessionConfig.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let session = URLSession(configuration: sessionConfig)
        self.defaultSession = session
    }
    
    func queryResults<T: Decodable>(request: Request) -> Future<T, Error> {
        return Future<T, Error>{[weak self] promise in
            guard let url = request.requestUrl(), let self = self else {
                promise(.failure(NetworkError.badURL))
                return
            }
            let dataTaskPublisher = self.defaultSession.dataTaskPublisher(for: url)
                .tryMap { (data: Data, response: URLResponse) in
                    guard let httpResponse = response as? HTTPURLResponse,
                            200...299 ~= httpResponse.statusCode else {
                        throw HTTPError.invalidStatusCode
                    }
                    return data
                }
                .decode(type: T.self, decoder: self.decoder)
                .receive(on: RunLoop.main)
            dataTaskPublisher.subscribe(Subscribers.Sink.init(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print(#function + ": Finished")
                case .failure(let error):
                    switch error {
                    case let decodingError as DecodingError:
                        promise(.failure(decodingError))
                    case let networkError as NetworkError:
                        promise(.failure(networkError))
                    default:
                        promise(.failure(error))
                    }
                }
            }, receiveValue: { response in
                promise(.success(response))
            }))
        }
    }
}

//
//  NetworkService.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import Foundation

fileprivate let timeoutIntervalForRequest = 5.0

public class NetworkService {
    static let instance = NetworkService()
    var dataTask: URLSessionDataTask?
    
    private let defaultSession: URLSession
    private let decoder = JSONDecoder()

    private init() {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = timeoutIntervalForRequest
        sessionConfig.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let session = URLSession(configuration: sessionConfig)
        self.defaultSession = session
    }
    

    func queryResults<T: Decodable>(request: QueryRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        dataTask?.cancel()
        guard let url = request.requestUrl() else {
            completion(.failure(.badURL))
            return
        }
        dataTask = defaultSession.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            guard let self = self else {return}
            defer { self.dataTask = nil }
            DispatchQueue.main.async {
                self.parsing(data: data, response: response, error: error, completion: completion)
            }
        })
        dataTask?.resume()
    }
    

    func parsing<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<T, NetworkError>) -> Void){
        guard let data = data,
            let response = response as? HTTPURLResponse,
              response.statusCode == HTTPStatusCode.ok.rawValue else {
            completion(.failure(.serverError))
            return
        }
        do {
            let response = try self.decoder.decode(T.self, from: data)
            completion(.success(response))
        } catch {
            print(error)
            completion(.failure(.decodeFail))
        }
    }
}

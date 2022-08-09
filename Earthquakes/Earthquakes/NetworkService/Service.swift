//
//  Service.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 8/9/22.
//

import Foundation
protocol Service {
    
    func queryResults<T: Decodable>(request: Request, completion: @escaping (Result<T, Error>) -> Void)
    
    func parsing<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<T, Error>) -> Void)
}

//
//  Service.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 8/9/22.
//

import Foundation
import Combine

protocol Service {
    func queryResults<T: Decodable>(request: Request) -> Future<T, Error>
}

//
//  Coordinator.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import Foundation

public protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
}

public extension Coordinator {
    
    func addChild(_ child: Coordinator) {
        children.append(child)
    }
    
    func removeChild(_ child: Coordinator) {
        children = children.filter { $0 !== child }
    }
    
}


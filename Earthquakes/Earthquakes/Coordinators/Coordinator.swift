//
//  Coordinator.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import Foundation

/// flow start
protocol Startable {
    func start()
}
/// flow end
protocol Finishable {
    func finish()
}

/// Coordinator can have children and weak
protocol Coordinator: AnyObject, Startable, Finishable {
    
    var children: [Coordinator] { get set }
    /// This parent MUST be **weak**
    var parent: Coordinator? { get set }
}

extension Coordinator {
    
    func addChild(_ child: Coordinator) {
        children.append(child)
        child.parent = self
    }
    
    func removeChild(_ child: Coordinator) {
        children = children.filter { $0 !== child }
    }
}


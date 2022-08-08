//
//  UICoordinator.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 8/7/22.
//

import UIKit

/// Base Coordinator for all UI Coordinator use
class UIBaseCoordinator: Coordinator {
    
    var navigationController: UINavigationController = UINavigationController()
    
    var children: [Coordinator] = []
    
    weak var parent: Coordinator?
    
    func start() {
        print("[Coordinator] 🟢 \(String(describing: self)) -> start")
    }
    
    func finish() {
        print("[Coordinator] 🟡 \(String(describing: self)) -> finish")
    }
}

//
//  EarthquakeDetailCoordinator.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 8/7/22.
//

import UIKit

final class EarthquakeDetailCoordinator: UIBaseCoordinator {
    
    private let urlStr: String?
    
    init(navigationController: UINavigationController, url: String?) {
        self.urlStr = url
        
        super.init()
        self.navigationController = navigationController
    }
    
    override func start() {
        super.start()
        guard let urlStr = urlStr else { return }
        let url = URL.init(string: urlStr)
        let vc = EarthquakeDetailViewController(url, coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        super.finish()
        navigationController.popViewController(animated: true)
    }
}

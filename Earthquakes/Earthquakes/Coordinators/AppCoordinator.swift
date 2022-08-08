//
//  AppCoordinator.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import UIKit

/// App Coordinator than will control the app flow
class AppCoordinator: UIBaseCoordinator {
    
    init(window: UIWindow?) {
        super.init()
        window?.rootViewController = navigationController
    }

    override func start() {
        super.start()
        let earthquakeListCoordinator = EarthquakeListCoordinator(navigationController: navigationController,
                                                                  dataProvider: EarthquakesListViewModelRemoteDataProvider())
        addChild(earthquakeListCoordinator)
        earthquakeListCoordinator.start()
    }
    
    override func finish() {
        children.forEach({$0.finish()})
        super.finish()
    }
}

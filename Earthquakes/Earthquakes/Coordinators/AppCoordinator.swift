//
//  AppCoordinator.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import UIKit
class AppCoordinator: Coordinator {

    var navigationController: UINavigationController
    var children = [Coordinator]()
    
    var dataProvider: DataProvider
    
    init(window: UIWindow?, dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        navigationController = UINavigationController()
        window?.rootViewController = navigationController
    }

    func start() {
        let earthquakeListCoordinator = EarthquakeListCoordinator(navigationController: navigationController,
                                                                  dataProvider: EarthquakesListRemoteDataProvider())
        addChild(earthquakeListCoordinator)
        earthquakeListCoordinator.start()
    }
}

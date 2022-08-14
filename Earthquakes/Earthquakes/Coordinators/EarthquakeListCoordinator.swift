//
//  EarthquakeListCoordinator.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import UIKit

protocol EarthquakeListCoordinatorHandler: AnyObject {
    var dataProvider: EarthquakesListRemoteDataProvider {get}
    func openDetailView(urlStr: String?)
    func errorHandling(_ error: Error, on view: UIView?)
}

class EarthquakeListCoordinator: UIBaseCoordinator {
    
    var dataProvider: EarthquakesListRemoteDataProvider
    
    init(navigationController: UINavigationController, dataProvider: EarthquakesListRemoteDataProvider) {
        self.dataProvider = dataProvider
        
        super.init()
        self.navigationController = navigationController
    }
    
    override func start() {
        super.start()
        guard let dataProvider = dataProvider as? EarthquakesListViewModelRemoteDataProvider else { return }
        let vc = EarthquakeListViewController(dataProvider, coordinator: self)
        navigationController.viewControllers = [vc]
    }
}

extension EarthquakeListCoordinator: EarthquakeListCoordinatorHandler {
    
    func openDetailView(urlStr: String?) {
        let coordinator = EarthquakeDetailCoordinator(navigationController: navigationController, url: urlStr)
        addChild(coordinator)
        coordinator.start()
    }
    
    /// show error msg on view
    func errorHandling(_ error: Error, on view: UIView?) {
        let message = (error as? NetworkError)?.localizedDescription ?? error as? String ?? error.localizedDescription
        let toast = ToastView.init()
        toast.showOn(view, message: message)
    }
}

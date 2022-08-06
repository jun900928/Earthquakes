//
//  EarthquakeListCoordinator.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import UIKit

class EarthquakeListCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var children = [Coordinator]()
    
    var dataProvider: RemoteDataProvider
    
    init(navigationController: UINavigationController, dataProvider: RemoteDataProvider) {
        self.navigationController = navigationController
        self.dataProvider = dataProvider
    }
    
    func start() {
        guard let dataProvider = dataProvider as? EarthquakesListRemoteDataProvider else { return }
        let vc = EarthquakeListViewController(dataProvider, coordinator: self)
        navigationController.viewControllers = [vc]
    }
    
    func openDetailWebview(urlStr: String?) {
        guard let urlStr = urlStr else { return }
        let url = URL.init(string: urlStr)
        let vc = EarthquakeDetailViewController(url, coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func errorHandling(_ error: Error, on view: UIView?) {
        let message = (error as? NetworkError)?.localizedDescription ?? error.localizedDescription
        let toast = ToastView.init()
        toast.showOn(view, message: message)
    }
}

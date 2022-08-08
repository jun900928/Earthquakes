//
//  EarthquakeDetailViewController.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 8/2/22.
//

import UIKit
import WebKit

class EarthquakeDetailViewController: UIViewController {
    
    let url: URL?
    
    weak var coordinator: EarthquakeDetailCoordinator?
    
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    init(_ url: URL?, coordinator: EarthquakeDetailCoordinator) {
        self.url = url
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            coordinator?.finish()
        }
    }
}

extension EarthquakeDetailViewController {
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        webView.constrainToSuperviewSafeAreaLayoutGuide()
        if let web_url = url {
            let web_request = URLRequest(url: web_url)
            webView.load(web_request)
        }
    }
}

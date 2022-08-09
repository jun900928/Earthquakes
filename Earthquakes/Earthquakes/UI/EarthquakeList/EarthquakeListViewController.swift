//
//  ViewController.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import UIKit

class EarthquakeListViewController: UIViewController {
    
    weak var coordinator: EarthquakeListCoordinatorHandler?
    
    let dataModelProvider: EarthquakeListCollectionViewDataModelProvider
    
    lazy var refreshButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Try Aagin"
        configuration.showsActivityIndicator = true
        configuration.imagePlacement = .top
        configuration.imagePadding = .sepearateSpace
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(refreshData), for: .touchUpInside)
        return button
    }()
    
    lazy var refresher:UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString.init(string: "Loading")
        refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refresher
    }()
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        cv.register(EarthquakeCollectionViewCell.self, forCellWithReuseIdentifier: EarthquakeCollectionViewCell.cellID)
        cv.register(RefreshCollectionViewCell.self, forCellWithReuseIdentifier: RefreshCollectionViewCell.cellID)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.alwaysBounceVertical = true
        return cv
    }()
    
    lazy var collectionViewDelegate: EarthquakeListCollectionViewDelegateFlowLayout = {
        let delegate = EarthquakeListCollectionViewDelegateFlowLayout(dataModelProvider, coordinator: coordinator)
        return delegate
    }()
    
    lazy var collectionViewDataSource: EarthquakeListViewControllerDataSource = {
        let ds = EarthquakeListViewControllerDataSource(dataModelProvider)
        return ds
    }()
    
    init(_ remoteDataProvider: EarthquakesListViewModelRemoteDataProvider, coordinator: EarthquakeListCoordinator?) {
        self.dataModelProvider = EarthquakeListCollectionViewDataModelProvider(remoteDataProvider, coordinator: coordinator)
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        refreshData()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    func setupUI() {
        self.title = "Earthquake"
        setupCollection()
        view.addSubview(refreshButton)
        refreshButton.constrainToLayoutMarginsGuide(edges: .centerX,.centerY)
        refreshButton.constrainTo(.width, c: 200)
        refreshButton.constrainTo(.height, c: 200)
    }
    
    func setupCollection() {
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
        collectionView.refreshControl = refresher
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDelegate
        collectionView.constrainToLayoutMarginsGuide(edges: .leading,.top,.bottom,.trailing)
    }
}


extension EarthquakeListViewController {
    /// refresh / update  the data
    @objc func refreshData(){
        beginRefreshing()
        let startTime = DateFormatter().formateData(date: Date.now.last30Days())
        let endtime = DateFormatter().formateData(date: .now)
        let config = QueryConfig.init(starttime: startTime, endtime: endtime, limit: pagesize)
        dataModelProvider.dataProvider.refreshRemoteData(config: config) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(_):
                self.title = self.dataModelProvider.remoteDataProvider.getTitle()
                self.collectionViewDataSource.updateDataModels()
                self.collectionView.reloadData()
            case .failure(let error):
                self.coordinator?.errorHandling(error, on: self.view)
            }
            self.endRefreshing()
            self.showRefreshButtonIfNeed()
        }
    }
    
    func beginRefreshing() {
        refresher.beginRefreshing()
        refreshButton.configuration?.showsActivityIndicator = true
    }
    
    func endRefreshing() {
        refresher.endRefreshing()
        refreshButton.configuration?.showsActivityIndicator = false
    }
    
    func showRefreshButtonIfNeed(hide required: Bool? = nil) {
        if let required = required {
            refreshButton.isHidden = required
        }else{
            guard let features = dataModelProvider.remoteDataProvider.getFeatures() else {
                refreshButton.isHidden = false
                return
            }
            refreshButton.isHidden = !features.isEmpty
        }
    }
}
    

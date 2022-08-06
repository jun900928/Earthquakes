//
//  RefreshCollectionViewCell.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 8/1/22.
//

import UIKit

protocol Refresher {
    func beginRefreshing()
    func endRefreshing()
}

class RefreshCollectionViewCell: UICollectionViewCell, CellIdentifierProvider{
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }

    private func addViews(){
        contentView.addSubview(activityIndicator)
        activityIndicator.constrainToLayoutMarginsGuide(edges: .centerX, .centerY, spacing: 0)
    }
}

extension RefreshCollectionViewCell: Refresher {
    func beginRefreshing() {
        activityIndicator.startAnimating()
    }
    
    func endRefreshing() {
        activityIndicator.stopAnimating()
    }
}

extension RefreshCollectionViewCell: CalculateSelfHeight {
    func calculateHieght(width: CGFloat) -> CGFloat {
        return .defaultCellHeight
    }
}

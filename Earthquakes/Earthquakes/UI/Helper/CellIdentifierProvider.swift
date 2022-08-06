//
//  CellIdentifierProvider.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/31/22.
//

import UIKit
///  Use clas name describing as identifier for the usage like UITableView, UICollectionView
protocol CellIdentifierProvider {
    static var cellID: String { get }
}

extension CellIdentifierProvider where Self: UIView {
    
    static var cellID: String {
        return String(describing: Self.self)
    }
}


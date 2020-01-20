//
//  ReuseIdentifiers.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/05.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit

protocol ReusableViewType {
    static var reuseID: String { get }
}

extension ReusableViewType {
    static var reuseID: String {
        return String(describing: self)
    }
}

extension UITableView {
    typealias ReusableCell = ReusableViewType & UITableViewCell
    typealias ReusableView = ReusableViewType & UITableViewHeaderFooterView
    
    func dequeueReusableCell<T: ReusableCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("\(T.self) is expected to have reusable identifier: \(T.reuseID)")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: ReusableView>(_ type: T.Type) -> T {
        guard let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: T.reuseID) as? T else {
            fatalError("\(T.self) is expected to have reusable identifier: \(T.reuseID)")
        }
        return headerFooter
    }
}

extension UICollectionView {
    typealias ReusableCell = ReusableViewType & UITableViewCell
    
    func dequeueReusableCell<T: ReusableCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("\(T.self) is expected to have reusable identifier: \(T.reuseID)")
        }
        return cell
    }
}


//
//  FeedViewPresenter.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/10.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit
import Toaster
import StoreKit

class FeedViewPresenter: NSObject {

    // MARK: - Properties
    
    private let storeService: StoreServiceType

    init(storeService: StoreServiceType) {
        self.storeService = storeService
    }
    
    var data: [StoreItemCategory: [StoreItem]] = [:]
    
    func fetchFeed() {
        for (index, api) in StoreAPI.allCases.enumerated() {
            storeService.fetchChan(of: api) { [weak self] result in
                guard let self = self else { return }
                result.success { items in
                    guard let category = StoreItemCategory(rawValue: index) else { return }
                    self.data[category] = items
                    NotificationCenter.default.post(name: FeedEvent.itemDidUpdated.name,
                                                    object: nil,
                                                    userInfo: ["section": index])
                }.catch { error in
                    NotificationCenter.default.post(name: FeedEvent.loadFailed.name,
                                                                   object: nil,
                                                                   userInfo: ["error": error])
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension FeedViewPresenter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return StoreItemCategory.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let category = StoreItemCategory(rawValue: section),
            let chan = data[category] {
            return chan.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedListCell.reuseID, for: indexPath) as? FeedListCell else {
            return .init()
        }
        
        guard let category = StoreItemCategory(rawValue: indexPath.section),
            let chan = data[category]?[indexPath.row] else {
                return cell
        }
        cell.configure(chan)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FeedViewPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FeedCategoryHeaderView.reuseID) as? FeedCategoryHeaderView else {
            return .init()
        }
        if let category = StoreItemCategory(rawValue: section) {
            headerView.configure(category)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = StoreItemCategory(rawValue: indexPath.section),
            let chan = data[category]?[indexPath.row] else {
                return
        }
        
        let toastingText = """
                            \(chan.title)
                            \(chan.discountedPrice ?? chan.originalPrice ?? "")
                            """
        Toast(text: toastingText).show()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

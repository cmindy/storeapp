//
//  FeedViewPresenter.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/10.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit

class FeedViewPresenter: NSObject {

    // MARK: - Section
    
    struct FeedSection {
        let category: StoreItemCategory
        let storeItems: [StoreItem]
    }

    // MARK: - Properties
    
    private var feedSections: [FeedSection] = []
    
    override init() {
        super.init()
        
        decodeJSON(assets: StoreItemCategory.allCases)
    }

    // MARK: - Methods
    
    private func decodeJSON(assets: [StoreItemCategory]) {
        let jsonDecoder = JSONDecoder()
        
        assets.forEach { asset in
            guard let dataAsset = NSDataAsset(name: asset.rawValue) else { return }
            do {
                let storeItems = try jsonDecoder.decode([StoreItem].self, from: dataAsset.data)
                feedSections.append(FeedSection(category: asset, storeItems: storeItems))
            } catch {
                print(error.localizedDescription)
            }
        }
        NotificationCenter.default.post(name: FeedEvent.itemDidUpdated.name, object: nil)
    }
}
// MARK: - UITableViewDataSource

extension FeedViewPresenter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedSections[section].storeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedListCell.reuseID, for: indexPath) as? FeedListCell else {
            return .init()
        }
        let storeItems = feedSections[indexPath.section].storeItems
        let storeItem = storeItems[indexPath.row]
        cell.configure(storeItem)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FeedViewPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FeedCategoryHeaderView.reuseID) as? FeedCategoryHeaderView else {
            return .init()
        }
        let category = feedSections[section].category
        headerView.configure(category)
        return headerView
    }
}
//
//  FeedViewPresenter.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/10.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit
import Toaster

class FeedViewPresenter: NSObject {

    // MARK: - Properties
    
    private var feedSections: [FeedSection] = []
    private let storeService: StoreServiceType
    init(storeService: StoreServiceType) {
        self.storeService = storeService
    }
    
    func fetchFeed() {
        let apis = StoreAPI.allCases
        for (index, api) in apis.enumerated() {
            storeService.chan(of: api) { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let items):
                    guard let category = StoreItemCategory(rawValue: api.rawValue) else { return }
                    let section = FeedSection(category: category, storeItems: items)
                    NotificationCenter.default.post(name: FeedEvent.itemDidUpdated.name, object: nil, userInfo: ["sections": IndexSet(integer: index)])
                    strongSelf.feedSections.append(section)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storeItems = feedSections[indexPath.section].storeItems
        let storeItem = storeItems[indexPath.row]
        
        let toastingText = """
                            \(storeItem.title)
                            \(storeItem.discountedPrice ?? storeItem.originalPrice ?? "")
                            """
        Toast(text: toastingText).show()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

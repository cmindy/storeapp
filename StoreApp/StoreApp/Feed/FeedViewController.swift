//
//  FeedViewController.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/05.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit
import StoreKit

class FeedViewController: UIViewController {

    // MARK: - Properties
    
    var presenter: FeedViewPresenter? {
        didSet {
            loadViewIfNeeded()
            DispatchQueue.global().async {
                self.presenter?.fetchFeed()
            }
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var feedTableView: UITableView!
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        setUpAttributes()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Methods
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadTableView),
                                               name: FeedEvent.itemDidUpdated.name,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(displayAlert),
                                               name: FeedEvent.loadFailed.name,
                                               object: nil)
    }
    
    // MARK: - Events
    
    @objc private func reloadTableView(_ notification: Notification) {
        guard let sections = notification.userInfo?["section"] as? Int else { return }
        print("section::::::::::: \(sections)")
        self.feedTableView.reloadSections([sections], with: .automatic)
    }
    
    @objc private func displayAlert(_ notification: Notification) {
        guard let error = notification.userInfo?["error"] as? Error else { return }
        print(error.localizedDescription)
    }
    
        }
    }
}

// MARK: - Attributes

extension FeedViewController {
    private func setUpAttributes() {
        setUpTableView()
    }
    
    private func setUpTableView() {
        let categoryHeaderView = UINib(nibName: FeedCategoryHeaderView.reuseID, bundle: nil)
        feedTableView.register(categoryHeaderView, forHeaderFooterViewReuseIdentifier: FeedCategoryHeaderView.reuseID)
        
        let feedCell = UINib(nibName: FeedListCell.reuseID, bundle: nil)
        feedTableView.register(feedCell, forCellReuseIdentifier: FeedListCell.reuseID)
        
        feedTableView.separatorStyle = .none
        feedTableView.sectionHeaderHeight = UITableView.automaticDimension
        feedTableView.estimatedSectionHeaderHeight = 70.0
        feedTableView.showsVerticalScrollIndicator = false
        
        feedTableView.dataSource = presenter
        feedTableView.delegate = presenter
    }
}

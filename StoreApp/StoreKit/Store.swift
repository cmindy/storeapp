//
//  Store.swift
//  StoreKit
//
//  Created by CHOMINJI on 2020/01/14.
//  Copyright © 2020 cmindy. All rights reserved.
//

import Foundation
import NetworkingKit

public protocol StoreServiceType {
    func fetchChan(of categories: StoreAPI, completion: @escaping (Result<[StoreItem], Error>) -> Void)
}

public struct StoreService: StoreServiceType {
    private let router: Router<StoreAPI>
    
    public init(router: Router<StoreAPI> = Router<StoreAPI>()) {
        self.router = router
    }
    
    public func fetchChan(of categories: StoreAPI, completion: @escaping (Result<[StoreItem], Error>) -> Void) {
        router.request(categories, completion)
    }
}

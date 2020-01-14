//
//  Store.swift
//  StoreKit
//
//  Created by CHOMINJI on 2020/01/14.
//  Copyright © 2020 cmindy. All rights reserved.
//

import Foundation
import NetworkingKit

protocol StoreServiceType {
    static func fetchChan(of categories: StoreAPI, completion: @escaping (Result<[StoreItem], Error>) -> Void)
}

public struct StoreService: StoreServiceType {
    public init() { }
    
    public static func fetchChan(of categories: StoreAPI, completion: @escaping (Result<[StoreItem], Error>) -> Void) {
        Router<StoreAPI>().request(categories, completion)
    }
    
}

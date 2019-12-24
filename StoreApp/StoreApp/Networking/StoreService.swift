//
//  StoreService.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/24.
//  Copyright © 2019 cmindy. All rights reserved.
//

import Foundation
    
class StoreService {
    private let networking: Router<StoreAPI>
    
    init(networking: Router<StoreAPI>) {
        self.networking = networking
    }
    
    func main(completion: @escaping (Result<[StoreItem], StoreError>) -> Void) {
        networking.request(.main, completion: completion)
    }
    
    func soup(completion: @escaping (Result<[StoreItem], StoreError>) -> Void) {
        networking.request(.soup, completion: completion)
    }
    
    func side(completion: @escaping (Result<[StoreItem], StoreError>) -> Void) {
        networking.request(.side, completion: completion)
    }
}

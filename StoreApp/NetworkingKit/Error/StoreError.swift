//
//  StoreError.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/21.
//  Copyright © 2019 cmindy. All rights reserved.
//

import Foundation

enum StoreError: Error {
    case unknown
    case invalidURL(url: String)
    case requestFailed
    case decodeFailed
}

//
//  EndPointType.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/21.
//  Copyright © 2019 cmindy. All rights reserved.
//

import Foundation

public protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

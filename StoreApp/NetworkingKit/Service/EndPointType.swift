//
//  EndPointType.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/21.
//  Copyright © 2019 cmindy. All rights reserved.
//

import Foundation

public protocol EndPointType {
    var baseURLString: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    func asURLRequest() throws -> URLRequest
}

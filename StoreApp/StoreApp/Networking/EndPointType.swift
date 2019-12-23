//
//  EndPointType.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/21.
//  Copyright © 2019 cmindy. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURLString: String { get }
    var method: HTTP.Method { get }
    var path: String { get }
    func asURLRequest() throws -> URLRequest
}
